class CommentsController < ApplicationController
  def create
    @upload = Upload.find(params[:upload_id])
    @comment = @upload.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :upload_id, :user_id)
  end
end

