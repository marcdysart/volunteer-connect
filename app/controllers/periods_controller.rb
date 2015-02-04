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
      start_date = Date.new(params[:search_from].to_i).beginning_of_year
      end_date = Date.new(params[:search_to].to_i).end_of_year
      @periods = Period.where("start >= ? AND start <= ?", start_date, end_date)
    else
      @periods = Period.order("start DESC")
    end
  end


  def show
    @period = Period.find(params[:id])
    @posts = @period.posts.paginate(page: params[:page], per_page: 6)
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

end
