class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]

  def show
    @user = User.find(params[:id])
    @uploads = Upload.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_without_password(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower
  end

  def mypage
    redirect_to user_path(current_user)
  end

  def tables
    @user = User.find(params[:user_id])
    @tables = Upload.where(user_id: @user.id)
  end

  def favorites
    @user = User.find(params[:user_id])
    @favorites = Favorite.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :avatar)
  end
end
