class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :locations
  accepts_nested_attributes_for :locations
  has_and_belongs_to_many :people
  accepts_nested_attributes_for :people
  has_and_belongs_to_many :periods
  accepts_nested_attributes_for :periods
  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments
  mount_uploader :image, ImageUploader

  default_scope { order('created_at DESC') }

  def self.search(query)
    where("name like ?", "%#{query}%")
  end

  def likes_count
      likes.where(value: 1).count
  end

  def points
     likes.sum(:value)
  end

  def update_rank
       age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
       new_rank = points + age_in_days

       update_attribute(:rank, new_rank)
  end

  def create_like
   user.likes.create(value: 1, post: self)
  end

  def save_with_initial_vote
    ActiveRecord::Base.transaction do
      post = Post.create(title: @title, body: @body)
      create_vote
    end
  end

end
