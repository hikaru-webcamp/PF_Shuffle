class User::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.all.order(updated_at: :desc).page(params[:page]).per(8)
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group), notice: "グループを作成しました"
    else
      render 'new'
    end
  end

  def join
    group = Group.find(params[:group_id])
    group_user = GroupUser.new(user_id: current_user.id, group_id: group.id) 
    group_user.save
    redirect_to group_path(group)
  end
  
  def groupout
    group = Group.find(params[:group_id])
    group.users.destroy(current_user)
    redirect_to group_path(group)
  end

  def show
    @group = Group.find(params[:id])
    @posts = Post.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "グループ情報を変更しました"
    else
      @group = Group.find(params[:id])
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: "グループを削除しました"
  end
  
  private

  def group_params
    params.require(:group).permit(:image,:name,:introduction,:owner_id)
  end
  
  # 他人のグループ編集ページにアクセスできないメソッドを定義
  # 他人のグループ編集ページをクリックすると、グループ一覧ページに遷移。
  def ensure_correct_user
  @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end