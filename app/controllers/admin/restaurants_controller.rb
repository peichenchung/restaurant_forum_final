class Admin::RestaurantsController < Admin::BaseController
  #before_action :authenticate_user! 
    #Devise提供的驗證方法,移到application_controller.rb
  #before_action :authenticate_admin 
    #自己寫的方法,(寫在superclass的ApplicationController中>>移到BaseController)
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]


  def index
    @restaurants = Restaurant.order(created_at: :desc).page(params[:page]).per(10)
    #原為@restaurant = Restaurant.all
    #利用Kaminari gem完成分頁功能
    #page 會根據分頁序數來篩選對應資料
    #per 決定一頁有幾筆資料
    #params[:page] 取得分頁數值,page方法就知道要讀取第幾頁的資料
  end

  def new
    @restaurant = Restaurant.new
    #建立新的餐廳實例@restaurant,然後將這個實例存入變數
    #Restaurant.new會透過Restaurant Model呼叫new方法,產生一個物件實例,在restaurants table建立新的一列空資料
    #將新建立的@restaurant送進View樣板,讓使用者填寫表單
  end

  def create
    @restaurant = Restaurant.new(restaurant_params) #透過params(private method)拿到使用者從表單輸入的資料
    #Restaurant.new會透過Restaurant Model再次呼叫new方法,把表單資料寫入@restaurant
    #呼叫save方法將資料存入
    if @restaurant.save #如果資料成功存入(表示驗證成功)
      flash[:notice] = "restaurant was successfully created"
      #flash方法的消息會保存到下一个action，和redirct_to方法一起使用
      redirect_to admin_restaurants_path #導回後台Index
    else #驗證失敗
      flash.now[:alert] = "restaurant was failed to create"
      #flash.now方法的消息只會在當前視窗顯示，不會保存到下一个action，和render方法一起使用
      render :new #留在new編輯畫面(render會保留原本有填入的欄位資料)
    end
  end

  def show
    #before_action :set_restaurant
  end

  def edit
    #before_action :set_restaurant
  end

  def update
    #before_action :set_restaurant
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully updated"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash.now[:alert] = "restaurant was failed to update"
      render :edit
    end
  end

  def destroy
    #before_action :set_restaurant
    @restaurant.destroy
    redirect_to admin_restaurants_path #回到index
    flash[:alert] = "restaurant was deleted"
  end


  private

  #Strong Parameters: 在讀取表單資料時，基於安全考量，必須在參數傳入時多做一層處理
  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description, :image, :category_id)
    #使用require(:restaurant)拿出表單資料
    #透過permit過濾資料,防止有人傳入不相關的惡意資訊
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
