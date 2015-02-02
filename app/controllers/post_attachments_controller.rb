class PostAttachmentsController < ApplicationController
  before_action :set_post_attachment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @post_attachments = PostAttachment.all
    respond_with(@post_attachments)
  end

  def show
    respond_with(@post_attachment)
  end

  def new
    @post_attachment = PostAttachment.new
    respond_with(@post_attachment)
  end

  def edit
  end

  def create
    @post_attachment = PostAttachment.new(post_attachment_params)
    @post_attachment.save
    respond_with(@post_attachment)
  end

  def update
    respond_to do |format|
       if @post_attachment.update(post_attachment_params)
         format.html { redirect_to @post_attachment.post, notice: 'Post attachment was successfully updated.' }
       end
     end
  end

  def destroy
    @post_attachment.destroy
    respond_with(@post_attachment)
  end

  private
    def set_post_attachment
      @post_attachment = PostAttachment.find(params[:id])
    end

    def post_attachment_params
      params.require(:post_attachment).permit(:post_id, :image)
    end
end
