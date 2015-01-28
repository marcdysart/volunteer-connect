class LikesController < ApplicationController

  def likes_count
    @post = Post.find(params[:post_id])

    @like = @post.likes.where(user_id: current_user.id).first

    if @like
      authorize @like, :update?
      @like.update_attribute(:value, 1)
    else
      @like = current_user.likes.create(value: 1, post: @post)
      authorize @like, :create?
      @like.save
    end
    redirect_to :back
  end


end
