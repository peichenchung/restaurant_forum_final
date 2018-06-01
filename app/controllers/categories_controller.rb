class CategoriesController < ApplicationController
  #如果使用者點擊「全部餐廳」時，會去呼叫的是restaurants#index
  #如果點擊的是任何一個分類按鈕，則會去呼叫categories#show
  def show
    @categories = Category.all #所有的分類資料
    @category = Category.find(params[:id]) #特定一筆分類資料
    @restaurants = @category.restaurants.order(created_at: :desc).page(params[:page]).per(9) #和該分類關聯的餐廳資料
  end
end
