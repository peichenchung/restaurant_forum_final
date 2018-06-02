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

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
