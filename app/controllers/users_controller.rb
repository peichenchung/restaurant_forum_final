class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :friend_list]

  def index
    @users = User.all.order(created_at: :desc) #最新加入的在前
  end

  def show
    #@user = User.find(params[:id])
    @commented_restaurants = @user.restaurants #取得使用者評論過的餐廳資料
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers = @user.followers # 需至 User Model 自訂方法
    @all_friends = current_user.all_friends
  end

  def edit
    #@user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    #@user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def friend_list
    #@user = User.find(params[:id])
    @all_friends = current_user.all_friends
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
