class User::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    return unless @comment.save
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.destroy
    # redirect_to group_post_path(group.id, post.id), notice: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
