class WelcomeController < ApplicationController
  def index
    unless user_signed_in?
      render 'logged_out_homepage', layout: 'logged_out' and return
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 6)
      @locations = Location.all
      render 'posts/index', layout: 'application' and return
    end

  end

  def about
    unless user_signed_in?
      render 'logged_out_about', layout: 'logged_out' and return
    end
  end

  def search
    unless user_signed_in?
      render 'search', layout: 'logged_out' and return
    end
  end

end
