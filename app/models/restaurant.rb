class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader

  #加入驗證程序,將name設為必填,若使用者未填寫餐廳名稱,就不會將這筆資料送進資料庫
  #與資料庫的互動由Model負責,所以寫在Restaurant Model中
  validates_presence_of :name

  belongs_to :category
  has_many :comments, dependent: :destroy #刪除Restaurant時,一併刪除關聯的評論

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  #def count_favorites >> 用counter_cache方法代替（寫在favorite.rb)
    #self.favorites_count = self.favorites.count
    #self.save
  #end
end
