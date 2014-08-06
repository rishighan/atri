class HomeController < ApplicationController
  def index
    @projects = Post.is_draft("no").group_by_category("include", "Projects")
  end

  def haiku
    render :template => "home/haiku"
  end
end
