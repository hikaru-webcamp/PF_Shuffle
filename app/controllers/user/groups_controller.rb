class User::GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @groups = Group.all
  end
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to group_path(@group)
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to group_path(@group)
  end
  
end

  private

  def group_params
    params.require(:group).permit(:image,:name,:introduction,:title,:body)
  end