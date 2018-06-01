class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #「使用者評論很多餐廳」的多對多關聯
  has_many :comments, dependent: :destroy #刪除user時, 刪除關聯的comments
  has_many :restaurants, through: :comments #透過此設定Rails會知道comments table扮演了Join Table的角色

  #「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy #刪除user時, 其相關favorite物件也一並被刪除
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
    # 在使用者評論過的餐廳中已用過 has_many :restaurants 的設定
    # 所以這裡不能用相同設定,否則使用object.restaurants方法時會無法分辨你是要查詢評論過的餐廳還是收藏的餐廳
    # 因此收藏關係指定自定義的名稱,另加來源source告知model name

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurants

  has_many :followships, dependent: :destroy #一個User擁有很多追蹤記錄(followships)
  has_many :followings, through: :followships #一個User透過追蹤記錄追蹤很多其他User(followings)
  #注意：如果關聯設定了:through, :dependent就會被忽略, 所以只在其中一行做設定

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name #註冊時name必填

  def admin?
    self.role == "admin" #會回傳True或False
  end

  def following?(user) #檢查追蹤記錄是否已經存在
    self.followings.include?(user)
  end
end
