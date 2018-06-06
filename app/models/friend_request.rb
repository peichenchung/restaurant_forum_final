class FriendRequest < ApplicationRecord
  belongs_to :user #每筆friend_request記錄,屬於送出friend_request的user
  belongs_to :friend, class_name: "User" #每筆friend_request記錄,屬於收到friend_request的user
end
