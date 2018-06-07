class FriendshipsController < ApplicationController
  def create #加好友
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      flash[:notice] = "Friend added"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy #刪除好友(雙方的friendships記錄都要刪除)
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @inverse_friendship = current_user.inverse_friendships.where(friend_id: current_user).first

    if @friendship.present?
      @friendship.destroy
    end

    if @inverse_friendship.present?
      @inverse_friendship.destroy
    end
    
    flash[:alert] = "Friend removed"
    redirect_back(fallback_location: root_path)
  end
end
