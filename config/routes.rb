Rails.application.routes.draw do
  devise_for :users #使用Devise建立User model時產生的
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #前台只能瀏覽餐廳資料
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy] #Nested Resources

    #自訂路由：最新動態和優惠活動都是針對Restaurant，所以放在resources :restaurants區塊中
    collection do #Collection: 用來操作model內全部的資料，因次不需要傳入ID
      get :feeds #瀏覽所有餐廳的最新動態

      get :tops #瀏覽top10人氣餐廳(加入favorite數最高)
    end

    member do #Member: 用來操作model裡的單一資料，因此需要傳入ID來指定單一個record
      get :dashboard #瀏覽個別餐廳的Dashboard(優惠活動)

      # 因為 favorite / unfavorite action 不需要樣板，所以我們習慣使用 POST，而不是 GET
      post :favorite
      post :unfavorite
      
      post :like
      post :unlike
    end
  end


  resources :users, only: [:index, :show, :edit, :update] #User profile
  resources :categories, only: :show
  root "restaurants#index"

  resources :followships, only: [:create, :destroy]

  namespace :admin do
    resources :restaurants #會產生一組URL Helper和網址 對應到不同的Action
    resources :categories
    root "restaurants#index"
  end
end
