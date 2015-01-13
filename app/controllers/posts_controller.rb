class PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    authorize @post


    end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end
end
