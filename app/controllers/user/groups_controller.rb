class User::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.all.order(updated_at: :desc).includes(:owner).page(params[:page]).per(12)
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.owner_id = current_user.id
    if group.save
      redirect_to group_path(group), notice: "グループを作成しました"
    else
      @groups = Group.all.order(updated_at: :desc).includes(:owner).page(params[:page]).per(12)
      @group = Group.new
      flash.now[:alert] = "グループを作成できませんでした"
      render "index"
    end
  end

  def join
    group = Group.find(params[:group_id])
    group_user = GroupUser.new(user_id: current_user.id, group_id: group.id)
    group_user.save
    redirect_to group_path(group.id), notice: "グループに加入しました"
  end

  def groupout
    group = Group.find(params[:group_id])
    group.users.destroy(current_user)
    redirect_to group_path(group.id), notice: "グループから脱退しました"
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def update
    group = Group.find(params[:id])
    if group.update(group_params)
      redirect_to group_path(group.id), notice: "グループ情報を変更しました"
    else
      @group = Group.find(params[:id])
      @users = @group.users.order(updated_at: :desc).page(params[:page]).per(12)
      flash.now[:alert] = "グループ情報を変更できませんでした"
      render "show"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end

  def group_post_index
    @posts = Post.all.order(updated_at: :desc).includes(:user, :group).page(params[:page]).per(12)
    @post_all = Post.all.includes(:user)

    respond_to do |format|
      format.html do
      end
      format.csv do
        send_data render_to_string, filename: "投稿一覧.csv", type: :csv
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(:image, :name, :introduction, :owner_id)
  end

  # 他人のグループ編集ページにアクセスできないメソッドを定義
  # 他人のグループ編集ページをクリックすると、グループ一覧ページに遷移。
  def ensure_correct_user
    @group = Group.find(params[:id])
    redirect_to groups_path unless @group.owner_id == current_user.id
  end
end
