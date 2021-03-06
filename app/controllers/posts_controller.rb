class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  layout "admin"

  # GET /posts
  # GET /posts.json
  def index
    @allposts = Post.is_draft('no').all
    @alldrafts = Post.is_draft('yes').all
    if params[:query].present?
      @posts = Post.search(params[:query])
    end
    # trending posts
    @trending = @allposts.map{|post| [post.title, post.excerpt, Pageviews.getTotalPageviews(Pageviews.getviews(post.friendly_id)), Pageviews.getviews(post.friendly_id), post.friendly_id, post.categories]}
    @trending = Pageviews.sortArray(@trending)
    # drafts
    @drafts = Post.limit(5).is_draft('yes')
  end

  def autocomplete
   render json: Post.search(params[:query], autocomplete: true, limit: 10).map do |post|
     {title: post.title, excerpt: post.excerpt, draft: post.is_draft}
   end
  end

  def allposts
    @allposts = Post.is_draft('no').all.order(:title).page params[:page]
    @alldrafts = Post.is_draft('yes')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.attachments.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
   @post = Post.new(post_params)
    if params.has_key?(:draft)
      @post.update_attribute(:is_draft , 'yes')
    else
      @post.update_attribute(:is_draft, 'no')
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      # updating the posts_categories join table
      # the general idea here is as follows:
      # take the input set set1 (form input params) and the existing set set2 (from the db)
      # find res1 = set1 - (set1 & set2) and res2 = set2 -(set1 & set2)
      # insert res1 in the join table and delete res2 from db.
      category_tags = params[:category_tags].split(',')
      formparams = Post.check_category(category_tags)
      existingtags = @post.categories.map(&:id)

      to_insert = formparams - (formparams & existingtags)
      to_delete = existingtags - (formparams & existingtags)

      # should insert only the ones from the form
      to_insert.each do |cat|
        @post.categories << Category.where(:id => cat)
      end
      # and delete the rest
      to_delete.each do |del|
        @post.categories.delete(Category.where(id: del))
      end

      Post.update(@post.id, post_params)
    #save as draft
    case params[:commit]
       when "Save Draft"
          @post.update_attribute(:is_draft, "yes")
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
       when "Update Post"
          @post.update_attribute(:is_draft, "no")
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
       else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :excerpt, :is_draft, :draft_status, {category_ids: []}, attachments_attributes:[:id, :picture, :_destroy])
    end
end
