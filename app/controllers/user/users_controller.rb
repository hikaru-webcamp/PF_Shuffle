class User::UsersController < ApplicationController
before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "会員情報を変更しました"
    else
      render :edit
    end
  end

  def out
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, alert: "退会しました"
  end
  # reset_sessionですべてのセッション情報を削除

  def out_confirm
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email)
  end

  # 他人の編集ページにアクセスできないメソッドを定義
  # 他人の編集ページをクリックすると、ログインしているユーザー詳細ページに遷移。
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
