class User::HomesController < ApplicationController
  def top
    @group_ranks = Group.where(id: GroupUser.group(:group_id).order('count(group_id) desc').limit(6).pluck(:group_id))
    @post_ranks = Post.where(id: Like.group(:post_id).order('count(post_id) desc').limit(6).pluck(:post_id))
    @admins = Admin.first(3)
  end
end
