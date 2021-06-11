class User::PostsController < ApplicationController
  
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end
  
  def show
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    @group = Group.find(params[:group_id])
    @post.user_id = current_user.id
    @post.group_id = @group.id
    @post.save
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to group_path(@group.id)
  end
  
  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end


  def update
    @group = Group.find(params[:group_id])
     @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group.id)
    else
      @group = Group.find(params[:group_id])
      @post = Post.find(params[:id])
      render "edit"
    end
  end

private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
end
