class PostsController < ApplicationController
  def index
    @posts = Post.all.where("posts.created_at > ?", 7.days.ago).paginate(page: params[:page], per_page: 10)
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
