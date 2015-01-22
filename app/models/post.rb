class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :locations
  accepts_nested_attributes_for :locations
  mount_uploader :image, ImageUploader

  default_scope { order('created_at DESC') }
end
