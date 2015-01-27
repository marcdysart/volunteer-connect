class LocationsController < ApplicationController
  respond_to :html, :js
  def destroy
    @post = Post.find(params[:post_id])
    @location = Location.find(params[:id])
    authorize @location

    if @location.destroy
      flash[:notice] = "Location was removed."
    else
      flash[:error] = "Location couldn't be deleted. Try again."
    end
  end

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    @locations = Location.all
    @posts = @location.posts.paginate(page: params[:page], per_page: 6)
    @comment = Comment.new
    authorize @location
  end

  def edit
    @post = Post.find(params[:post_id])
    @location = Location.find(params[:id])
    authorize @location
  end

  def new
    @location = Location.new
    authorize @location
  end

  def create
    @location = Location.all.build(location_params)
    @new_location = Location.new
    authorize @location

    if @location.save
      flash[:notice] = "Location was saved."
      redirect_to new_post_path
    else
      flash[:error] = "There was an error saving the location. Please try again."
    end

  end

  private

  def location_params
    params.require(:location).permit(:name)
  end

end
