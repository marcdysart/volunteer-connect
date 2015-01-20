class LocationsController < ApplicationController

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
    @post = Post.find(params[:post_id])
    @location = Location.new
    @locations = @post.locations
  end

  def show
    @post = Post.find(params[:post_id])
    @location = Location.new
    @locations = @post.locations
  end

  def edit
    @post = Post.find(params[:post_id])
    @location = Location.find(params[:id])
    authorize @location
  end

  def new
    @post = Post.find(params[:post_id])
    @location = Location.new
    authorize @location
  end

  def create
    @post = Post.find(params[:post_id])
    @locations = @post.locations
    @location = Location.build(location_params)
    @new_location_for_post = @post.locations.build(location_params)
    @location.post  = @post
    @new_location = Location.new
    authorize @location

    if @location.save
      flash[:notice] = "Location was saved."
    else
      flash[:error] = "There was an error saving the location. Please try again."
    end

  end

  private

  def location_params
    params.require(:location).permit(:name)
  end

end
