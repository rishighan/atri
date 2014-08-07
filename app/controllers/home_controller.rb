class HomeController < ApplicationController
  layout 'site_layout', only: [:index]

  def index
    @projects = Post.is_draft("no").group_by_category("include", "Projects")
    @posts = Post.is_draft("no").group_by_category("include", "Hero","General")
    # All posts tagged with everything other than projects will be in the main body
    @log = Post.is_draft("no").group_by_category("exclude", "Projects, Hero")
  end

  def haiku
    render :template => "home/haiku"
  end
end
