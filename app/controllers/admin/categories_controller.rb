class Admin::CategoriesController < Admin::BaseController
  #before_action :authenticate_user!
    #Devise提供的驗證方法,判斷使用者是否登入(移到application_controller.rb)
  #before_action :authenticate_admin
    #自己寫的方法,(寫在superclass的ApplicationController中>>移到BaseController)
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id])
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "category was successfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def update
    #@category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
      flash[:notice] = "category was successfully updated"
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    #@category = Category.find(params[:id])
    if @category.destroy
      flash[:alert] = "category was successfully deleted"
      redirect_to admin_categories_path
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
      redirect_to admin_categories_path
    end
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
