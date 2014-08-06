class HomeController < ApplicationController
  def index

  end

  def haiku
    render :template => "home/haiku"
  end
end
