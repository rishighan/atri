class HomeController < ApplicationController
  layout 'site_layout', only: [:index, :projects]

  def index
    #mechanism to filter our only "Hero" posts that may fall into whatever
    #categories I specify
    @projectheroes = Post.is_draft("no").projects & Post.hero
    @postheroes = Post.is_draft("no").group_by_category("include", ["General", "Technical"]) & Post.hero

    # All posts tagged with everything other than the hero category will be in the main body
    @log = Post.is_draft("no").group_by_category("exclude", ["Projects", "Hero", "Feature"]).page(params[:page]).per(10)

    # thanks to centrx, this here takes the id, and categories.title and converts it to a hash
    # I then use this in the view to check for "Highlights" and style it differently
    @ha = @log.map { |p| [p.id, p.categories.map(&:title)] }.to_h


  end

  def haiku
    render :template => "home/haiku"
  end

  def projects
    #render the project template
    @projects = Post.is_draft("no").projects

  end

  def project
    # finds just projects with the supplied Id
    # built in exception handling for "id not found"
    @project = Post.projects.find(params[:id])
    render layout: "project_page_layout"
  end

  def colophon
  end

  def archive
    #group by created_at date
    @archive = Post.is_draft("no").group_by_category("exclude", ["Projects", "Hero"]).group_by {|x| x.created_at.beginning_of_month}
  end


end
