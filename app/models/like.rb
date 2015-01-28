class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  after_save :update_post
  def likes_count?
    value == 1
  end

  private

  def update_post
    post.update_rank
  end
end
