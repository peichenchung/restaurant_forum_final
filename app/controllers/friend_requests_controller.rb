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
