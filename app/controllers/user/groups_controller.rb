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
    if @group.save
      group_user = GroupUser.new(user_id: current_user.id, group_id: @group.id)
      group_user.save
      redirect_to group_path(@group)
    else
      @group = Group.new
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end

  private

  def group_params
    params.require(:group).permit(:image,:name,:introduction,:title,:body)
  end