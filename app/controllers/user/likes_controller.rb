class User::LikesController < ApplicationController
  before_action :set_like, only: %i[create destroy]

  def create
    like = current_user.likes.new(post_id: @post.id)
    like.save
  end

  def destroy
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end

  def set_like
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
  end
end
