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
    if params[:search]
      @locations = Location.search(params[:search]).order("created_at DESC")
    else
      @locations = Location.order("name ASC")
    end
  end

  def show
    @location = Location.find(params[:id])

    if params[:filter]
      @person =  Person.find_by(name: params[:filter])
      @user = User.find_by(name: params[:filter])
      # This will show posts that have tags by this name and all the posts written by this name
      if @user.nil?
        @posts = @location.posts.joins(:people).where(people: {id: @person.id} )
        # @posts = (@person.posts & @location.posts)
      else
        @posts = @location.posts.joins(:people).where(people: {id: @person.id} ) + (@user.posts & @location.posts)
        # @posts = (@person.posts & @location.posts) + (@user.posts & @location.posts)
      end
      # @posts = Location.find(params[:id]).joins(:posts).tagged_with(@person)
    else
      @posts = @location.posts.paginate(page: params[:page], per_page: 6)
    end
    @locations = Location.all
    # This is code to get all the people to be unique  Something like
    # @people = @posts.joins(:people).uniq
    
    get_unique_people
    @unique_people = @pop.uniq




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

  def get_unique_people
    @pop = []
    @posts.each do |post|
      post.people.each do |person|
        @pop.push(person)
      end
      @pop.push(post.user.person)
    end
  end

end
