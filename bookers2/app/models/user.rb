class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :favorites ,dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # フォローされている状況
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォロワー
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # フォローする状況
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローした人
  has_many :followings, through: :relationships, source: :followed
  
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  has_many :chats
  
  has_one_attached :profile_image
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
 def get_profile_image (width,height)
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
 end
 
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
end
