class HomeController < ApplicationController
  layout 'site_layout', only: [:index]

  def index
    #mechanism to filter our only "Hero" posts that may fall into whatever
    #categories I specify
    @projects = Post.is_draft("no").projects & Post.hero
    @posts = Post.is_draft("no").group_by_category("include", ["General", "Technical"]) & Post.hero
    # All posts tagged with everything other than projects will be in the main body
    @log = Post.is_draft("no").group_by_category("exclude", ["Projects", "Hero", "Feature"]).page(params[:page]).per(10)

  end

  def haiku
    render :template => "home/haiku"
  end

  def projects
    #render the project template
    render template: "projects/index"
  end

  def colophon
  end

  def archive

  end
end
