class PeopleController < ApplicationController
  respond_to :html, :js
  def destroy
    @post = Post.find(params[:post_id])
    @person = Person.find(params[:id])
    authorize @person

    if @person.destroy
      flash[:notice] = "Person was removed."
    else
      flash[:error] = "Person couldn't be deleted. Try again."
    end
  end

  def index
    if params[:search]
      @people = Person.search(params[:search]).order("created_at DESC")
    else
      @people = Person.order("name ASC")
    end
  end

  def show
    @person = Person.find(params[:id])
    unless @person.user.nil?
      @user = User.find(@person.user.id)
    end
    if params[:filter]
      @location =  Location.find_by(name: params[:filter])

      # This will show posts that have tags by this name and all the posts written by this name
      if @user.nil?
        # @posts = (@person.posts & @location.posts)
        @posts = @person.posts.joins(:locations).where(locations: {id: @location.id} )
      else
        @posts = (@person.posts.joins(:locations).where(locations: {id: @location.id} )) + (@user.posts & @location.posts)
      end
    else
      @posts = @person.posts.paginate(page: params[:page], per_page: 6)
    end

    get_all_locations
    @unique_locations = @loc.uniq
    @comment = Comment.new
    authorize @person
  end

  def edit
    @post = Post.find(params[:post_id])
    @person = Person.find(params[:id])
    authorize @person
  end

  def new
    @person = Person.new
    authorize @person
  end

  def create
    @person = Person.all.build(person_params)
    @new_person = Person.new
    authorize @person

    if @person.save
      flash[:notice] = "Person was saved."
      redirect_to new_post_path
    else
      flash[:error] = "There was an error saving the person. Please try again."
    end

  end

  private

  def person_params
    params.require(:person).permit(:name)
  end

  def get_all_locations
    @loc = []
    @posts.each do |post|
      post.locations.each do |location|
        @loc.push(location)
      end
      # @loc.push(post.user.location)  you can add this once user.location is created
    end
  end

end
