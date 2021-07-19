class User::GroupsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_group, only: %i[show update destroy]
  before_action :set_group_join, only: %i[group_join group_out]

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
      redirect_to request.referer
      flash[:danger] = "グループ作成に失敗しました"
    end
  end

  def group_join
    group_user = GroupUser.new(user_id: current_user.id, group_id: @group.id)
    group_user.save
    redirect_to group_path(@group.id), notice: "グループに加入しました"
  end

  def group_out
    @group.users.destroy(current_user)
    redirect_to group_path(@group.id), notice: "グループから脱退しました"
  end

  def show
    @users = @group.users.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group.id), notice: "グループ情報を変更しました"
    else
      redirect_to request.referer
      flash[:danger] = "グループ情報を変更できませんでした"
    end
  end

  def destroy
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

  def set_group
    @group = Group.find(params[:id])
  end

  def set_group_join
    @group = Group.find(params[:group_id])
  end
end
