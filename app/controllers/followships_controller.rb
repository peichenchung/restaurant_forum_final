class FollowshipsController < ApplicationController
  def create #follow
    #產生一個新的Followship物件,並設定兩個外鍵user_id和following_id
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save #將攜帶資料的Followship物件存入資料庫
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy #unfollow
    #在followships table上查詢出一筆資料,其外鍵符合current_user與前端傳進來的params[:id]
    @followship = current_user.followships.where(following_id: params[:id]).first
    #用where方法會回傳一個物件集合(陣列),所以需要再串接first,將特地物件從陣列取出
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
