class RestaurantsController < ApplicationController
  #before_action :authenticate_user!
    #移到application_controller.rb
  before_action :set_restaurant, only: [:dashboard, :favorite, :unfavorite, :like, :unlike]

  #前台首頁
  def index
    @restaurants = Restaurant.order(created_at: :desc).page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  #最新動態
  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10) #新到舊,只顯示10筆
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  #TOP10人氣餐廳
  def tops
    @top_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

  def dashboard
    #@restaurant = Restaurant.find(params[:id])
  end

  def favorite
    #@restaurant = Restaurant.find(params[:id])
    #如果已在我的最愛(避免重複加入favorites table)
    if @restaurant.is_favorited?(current_user)
      #跳出提示訊息表示已加入
      flash[:alert] = "already in favorite list"
    else
      @restaurant.favorites.create!(user: current_user) #寫法有很多種,請參考教案
      #@restaurant.count_favorites >> 用counter_cache方法代替（寫在favorite.rb)
    end
    redirect_back(fallback_location: root_path) #回上頁
  end

  def unfavorite
    #@restaurant = Restaurant.find(params[:id])
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all #因為上述程式碼查找出來會是一個集合,所以要用destroy_all而不是destroy
    #@restaurant.count_favorites >> 用counter_cache方法代替（寫在favorite.rb)
    redirect_back(fallback_location: root_path)
  end

  def like
    #@restaurant = Restaurant.find(params[:id])
    if @restaurant.is_liked?(current_user)
      flash[:alert] = "already liked"
    else
      @restaurant.likes.create!(user: current_user)
    end
    redirect_back(fallback_location: root_path)
  end

  def unlike
    #@restaurant = Restaurant.find(params[:id])
    likes = Like.where(restaurant: @restaurant, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end
