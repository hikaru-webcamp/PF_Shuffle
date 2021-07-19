class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted, :profile_image, :introduction)
  end
end
