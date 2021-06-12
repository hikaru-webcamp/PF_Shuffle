class User::LikesController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end
end
