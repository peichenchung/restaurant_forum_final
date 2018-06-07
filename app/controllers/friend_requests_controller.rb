class FriendRequestsController < ApplicationController

  def create #送出交友請求
    friend = User.find(params[:friend_id])
    #使用者在User列表上點下某User的Friend按鈕,網址會攜帶參數friend_id=user.id
    @friend_request = current_user.friend_requests.new(friend: friend)
    #根據params[:friend_id]為current_user新增一筆friend_request記錄

    if @friend_request.save #搭配唯一性驗證,user不能重複送出friend_request給同一user
      flash[:notice] = "Friend Request Sent"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "You already sent a friend request"
      redirect_back(fallback_location: root_path)
    end
  end


  def update #接受交友請求
    #雙方成為好友(在Friendship新增雙方的friendships記錄)
    current_user.friendships.create!(friend_id: params[:friend_id])
    current_user.inverse_friendships.create!(user_id: params[:friend_id])

    #刪除(收到的)交友請求記錄
    @friend_request = current_user.inverse_friend_requests.where(friend_id: params[:id]).first
    @friend_request.destroy

    flash[:notice] = "You just accepted a friend request"
    redirect_back(fallback_location: root_path)
  end


  def destroy #取消送出的交友請求 #cancel按鈕放在自己的好友列表中
    @friend_request = current_user.friend_requests.where(friend_id: params[:friend_id]).first

    if @friend_request.present?
      @friend_request.destroy
    end

    flash[:alert] = "You just canceled a friend request"
    redirect_back(fallback_location: root_path)
  end


  def reject #拒絕(別人的)好友請求
    @inverse_friend_request = current_user.inverse_friend_requests.where(friend_id: params[:id]).first

    if @inverse_friend_request.present?
      @inverse_friend_request.destroy
    end

    flash[:alert] = "You just rejected a friend request"
    redirect_back(fallback_location: root_path)
  end

end
