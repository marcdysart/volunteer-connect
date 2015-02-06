class PeriodsController < ApplicationController

  def destroy
    @post = Post.find(params[:post_id])
    @period = Period.find(params[:id])
    authorize @period

    if @period.destroy
      flash[:notice] = "Date was removed."
    else
      flash[:error] = "Date couldn't be deleted. Try again."
    end
  end


  def index
    if params[:search_from]
      @start_date = Date.new(params[:search_from].to_i).beginning_of_year
      @end_date = Date.new(params[:search_to].to_i).end_of_year
      @periods = Period.where("start >= ? AND start <= ?", @start_date, @end_date)
      get_unique_people
      @unique_people = @pop.uniq
    else
      @periods = Period.order("start DESC")
    end

    if params[:filter]
      @person = Person.find_by(name: params[:filter])
      #This finds all the user who has the same name as the filter.
      @user = User.find_by(name: params[:filter])
      # This will show posts that have tags by this name and all the posts written by this name
      get_posts_from_all_periods_of_one_person
      if @user.nil?
        @posts = @period_person_posts.uniq
      else
        get_posts_from_all_periods
        @posts = @period_person_posts + (@user.posts & @period_posts)
      end

    else

    end



  end


  def show
    @period = Period.find(params[:id])
    if params[:filter]
      @person = Person.find_by(name: params[:filter])
      #This finds all the user who has the same name as the filter.
      @user = User.find_by(name: params[:filter])
      # This will show posts that have tags by this name and all the posts written by this name
      if @user.nil?
        @posts = @period.posts.joins(:people).where(people: {id: @person.id} )
      else
        @posts =@period.posts.joins(:people).where(people: {id: @person.id} ) + (@user.posts & @period.posts)
      end

    else
      @posts = @period.posts.paginate(page: params[:page], per_page: 6)
    end
    get_unique_people_for_show
    @unique_people = @pop.uniq

    @comment = Comment.new
    authorize @period
  end

  def edit
    @post = Post.find(params[:post_id])
    @period = Period.find(params[:id])
    authorize @period
  end

  def new
    @period = Period.new
    authorize @period
  end

  def create
    @period = Period.all.build(period_params)
    @new_period = Period.new
    authorize @period

    if @period.save
      flash[:notice] = "Period was saved."
      redirect_to new_post_path
    else
      flash[:error] = "There was an error saving the person. Please try again."
    end

  end

  private

  def period_params
    params.require(:period).permit(:start, :end)
  end

  def get_unique_people
    @pop = []
    @periods.select(&:present?).each do |period|
      period.posts.each do |post|
        post.people.each do |person|
          @pop.push(person)
        end
      @pop.push(post.user.person)
      end
    end
  end

  def get_unique_people_for_show
    @pop = []
    @period.posts.each do |post|
      post.people.each do |person|
        @pop.push(person)
      end
    @pop.push(post.user.person)
    end
  end


  def get_posts_from_all_periods_of_one_person
    @period_person_posts = []
    @periods.select(&:present?).each do |period|
         @period_person_posts.push(period.posts.joins(:people).where(people: {id: @person.id} ))
    end
  end

  def get_posts_from_all_periods
    @period_posts = []

    @periods.select(&:present?).each do |period|
        period.posts.each do |post|
          @period_posts.push(post)
        end
    end
  end



end
