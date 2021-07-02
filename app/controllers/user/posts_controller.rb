class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:new, :edit, :update]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def index
    @group = Group.find(params[:group_id])
    @posts = @group.posts.order(updated_at: :desc).page(params[:page]).per(12)
  end

  def show
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @group = Group.find(params[:group_id])
    @post.user_id = current_user.id
    @post.group_id = @group.id
    url = params[:post][:youtube_url] # 取得したい情報を指定
    url = url.last(11)                # 11桁の値(video_id)を取り出し、変数urlに格納
    @post.youtube_url = url           # 変数urlの値をインスタンス変数に格納
    if @post.save
      redirect_to group_post_path(@group, @post), notice: "投稿しました"
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

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to group_post_path(@group, @post), notice: "投稿情報を更新しました"
    else
      @group = Group.find(params[:group_id])
      @post = Post.find(params[:id])
      render "edit"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :youtube_url)
  end

  def ensure_correct_user
    @group = Group.find(params[:group_id])
    @users = @group.users
    redirect_to group_path(@group) unless @users.include?(current_user) || @group.owner_id == current_user.id
  end
end
