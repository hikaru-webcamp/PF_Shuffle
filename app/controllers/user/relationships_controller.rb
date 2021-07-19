class User::RelationshipsController < ApplicationController
  before_action :set_user, only: %i[create destroy following follower]

  def create
    current_user.follow(@user)
  end

  def destroy
    current_user.unfollow(@user)
  end

  def following
    @following_users = @user.following_users.page(params[:page]).per(12)
  end

  def follower
    @follower_users = @user.follower_users.page(params[:page]).per(12)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
