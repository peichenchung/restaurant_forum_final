class FriendRequest < ApplicationRecord
  validates :friend_id, uniqueness: { scope: :user_id }
  #唯一性驗證,user不能重複送出friend_request給同一user

  belongs_to :user #每筆friend_request記錄,屬於送出friend_request的user
  belongs_to :friend, class_name: "User" #每筆friend_request記錄,屬於收到friend_request的user
end
