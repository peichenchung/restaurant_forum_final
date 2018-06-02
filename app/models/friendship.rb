class Friendship < ApplicationRecord
  belongs_to :user #每筆friendship記錄屬於加他人好友的user
  belongs_to :friend, class_name: "User" #每筆friendship紀錄屬於被加為好友的user
end
