class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def update
    if params['profile_button']
      if current_user.update_attributes(user_params)
        flash[:notice] = "User information updated"
        redirect_to profile_path
      else
        flash[:error] = "Invalid user information"
        redirect_to profile_path
      end
    else
      if current_user.update_attributes(user_params)
        flash[:notice] = "User information updated"
        redirect_to edit_user_registration_path
      else
        flash[:error] = "Invalid user information"
        redirect_to edit_user_registration_path
      end
    end


  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @comments = @user.comments
  end

  def index

  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :aboutme)
  end
  end
