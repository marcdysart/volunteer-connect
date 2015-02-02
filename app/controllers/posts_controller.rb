class PostsController < ApplicationController
  def index
    if params[:search]
      @posts = Post.all.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 6)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_attachments = @post.post_attachments.all
    @location = Location.all
    @person = Person.all
    @period = Period.all
    @comment = Comment.new
    authorize @post
  end

  def new
    @post = Post.new
    @post_attachment = @post.post_attachments.build
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
      params[:post_attachments]['image'].each do |a|
          @post_attachment = @post.post_attachments.create!(:image => a, :post_id => @post.id)
       end
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

  def query
      q = params[:query]
      @locations = Location.search(name_cont: q).result
      @people = Person.search(name_cont: q).result

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
    params.require(:post).permit(:title, :body, :image, :image_cache, :url_link, :location_ids => [], :person_ids => [], :period_ids => [], post_attachments_attributes: [:id, :post_id, :image])
  end


end
