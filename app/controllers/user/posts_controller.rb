class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[new index show create update destroy]
  before_action :set_post, only: %i[show update destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = @group.posts.includes(:user).order(updated_at: :desc).page(params[:page]).per(12)
  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html do
      end
      format.csv do
        send_data render_to_string, filename: "投稿詳細.csv", type: :csv
      end
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.group_id = @group.id
    params_url = params[:post][:youtube_url] # 取得したい情報を指定
    url = params_url.last(11)
    @post.youtube_url = url
    if @post.save
      redirect_to group_post_path(@group, @post), notice: "投稿しました"
    else
      redirect_to request.referer
      flash[:danger] = "投稿に失敗しました"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to group_post_path(@group, @post), notice: "投稿情報を更新しました"
    else
      redirect_to request.referer, notice: "投稿情報を変更できませんでした"
    end
  end

  def destroy
    @post.destroy
    redirect_to group_posts_path(@group.id), notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :youtube_url)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
