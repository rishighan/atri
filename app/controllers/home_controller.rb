class HomeController < ApplicationController
  layout 'site_layout'

  def index
    @projects = Post.is_draft("no").group_by_category("include", "Projects")
    @posts = Post.is_draft("no").group_by_category("include", "General")
  end

  def haiku
    render :template => "home/haiku"
  end
end
