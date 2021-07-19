module Search
  extend ActiveSupport::Concern

  def search
    @keyword = params[:word]
    redirect_to request.referer, notice: "検索文字を入れて下さい" if @keyword.blank?
    searcher = Searcher.new(params[:word].split(/[[:blank:]]+/))

    @users = Kaminari.paginate_array(searcher.users).page(params[:page]).per(12)
    @groups = Kaminari.paginate_array(searcher.groups).page(params[:page]).per(12)
    @posts = Kaminari.paginate_array(searcher.posts).page(params[:page]).per(12)
  end
end
