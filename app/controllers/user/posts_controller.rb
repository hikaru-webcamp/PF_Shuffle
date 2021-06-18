class User::PostsController < ApplicationController
  
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end
  
  def index
    @group = Group.find(params[:group_id])
    @posts = @group.posts.order(updated_at: :desc).page(params[:page]).per(8)
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
    if @post.save
      redirect_to group_posts_path(@group), notice: "投稿しました"
    else
    @group = Group.find(params[:group_id])
    @post = Post.new
      render 'new'
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to group_posts_path(@group.id), notice: "投稿を削除しました"
  end
  
  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end


  def update
    @group = Group.find(params[:group_id])
     @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group.id), notice: "投稿情報を更新しました"
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
