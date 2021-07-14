class User::HomesController < ApplicationController
  def top
    @group_ranks = Group.all_group_ranks # Group.rbでメソッド定義
    @post_ranks = Post.all_post_ranks # Post.rbでメソッド定義
    @admins = Admin.first(6)
  end
end
