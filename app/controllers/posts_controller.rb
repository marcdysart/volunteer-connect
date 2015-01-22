class PostsController < ApplicationController
  def index
    @posts = Post.all.where("posts.created_at > ?", 7.days.ago).paginate(page: params[:page], per_page: 6)
  end

  def show
    @post = Post.find(params[:id])
    @location = Location.all
    @person = Person.all
    @period = Period.all
    @comment = Comment.new
    authorize @post
  end

  def new
    @post = Post.new
    @location = Location.new
    @locations = Location.all
    @person = Person.new
    @people = Person.all
    @period = Period.new
    @periods = Period.all
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize @post
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    @locations = @post.locations
    @people = @post.people
    @period = @post.periods
    authorize @post

    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end


  def destroy
    @post = Post.find(params[:id])
    authorize @post
    title = @post.title
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to posts_path
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :image_cache, :url_link, :location_ids => [], :person_ids => [], :period_ids => [])
  end


end
