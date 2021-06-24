class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :ensure_guest_user, only: [:update, :edit]

  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "会員情報を変更しました"
    else
      render :edit
    end
  end

  def out
    @user = current_user
    if @user.email == "user1@test.com"
      redirect_to user_path(current_user),alert: "テストユーザーは退会できません"
    else  
      @user.update(is_deleted: true)
      reset_session
      redirect_to root_path, alert: "退会しました"
    end
  end
  # reset_sessionですべてのセッション情報を削除してログアウトさせる

  def out_confirm; end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email)
  end

  # 他人の編集ページにアクセスできないメソッドを定義
  # 他人の編集ページをクリックすると、ログインしているユーザー詳細ページに遷移。
  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
  #ゲストユーザーを編集できないように設定
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
       redirect_to user_path(current_user) , alert: 'ゲストユーザーは編集できません'
    end   
  end
end
