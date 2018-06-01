class Admin::BaseController < ApplicationController
  before_action :authenticate_admin #自己寫的方法,(原寫在superclass的ApplicationController中)

  private

  def authenticate_admin
    unless current_user.admin? # admin? 方法寫在User model
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

end