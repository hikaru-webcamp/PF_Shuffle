class User::SearchesController < ApplicationController
  def search
    @keyword = params[:word]
    redirect_to request.referer, notice: "検索文字を入れて下さい" if @keyword.blank? # キーワードが入力されていないと遷移元に
    split_keyword = params[:word].split(/[[:blank:]]+/) # splitで配列にして対応 blankは全角スペースの対応
    # 配列化
    users = []
    groups = []
    posts = []
    split_keyword.each do |keyword| # 分割したキーワードごとに検索
      next if keyword == "" # 検索先頭文字の空白対策 nextで次のループ処理
      users += User.where("name LIKE(?) OR introduction LIKE(?)", "%#{keyword}%", "%#{keyword}%").order(created_at: :desc)
      groups += Group.where("name LIKE(?) OR introduction LIKE(?)", "%#{keyword}%", "%#{keyword}%").includes([:owner]).order(created_at: :desc)
      posts += Post.where("title LIKE(?) OR body LIKE(?)", "%#{keyword}%", "%#{keyword}%").includes(:user, :group).order(created_at: :desc)
    end
    # ====検索ワード２つの時にレコードが重複の対策 配列から重複情報を削除 ====
    users.uniq!
    groups.uniq!
    posts.uniq!

    @users = Kaminari.paginate_array(users).page(params[:page]).per(12)
    @groups = Kaminari.paginate_array(groups).page(params[:page]).per(12)
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(12)
  end
end
