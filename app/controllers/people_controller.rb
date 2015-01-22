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
    @post = Post.find(params[:post_id])
    @person = Person.new
    @people = @post.people
  end

  def show
    @person = Person.find(params[:id])
    @posts = @person.posts.paginate(page: params[:page], per_page: 6)
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

end
