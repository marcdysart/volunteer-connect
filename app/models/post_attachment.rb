class PostAttachment < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  belongs_to :post
end
