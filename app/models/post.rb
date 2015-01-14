class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  mount_uploader :image, ImageUploader

  default_scope { order('created_at DESC') }
end
