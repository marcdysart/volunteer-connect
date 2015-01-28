class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :person

  mount_uploader :avatar, AvatarUploader

   def admin?
     role == 'admin'
   end

   def member?
     role == 'member'
   end

   def liked(post)
     likes.where(post_id: post.id).first
   end
end
