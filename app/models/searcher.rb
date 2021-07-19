class Searcher
  # .newされた時、initializeメソッド自動呼び出して、インスタンス変数の初期値を設定
  def initialize(keywords)
    @keywords = keywords

    freeze
  end

  def users
    array = []
    @keywords.each do |keyword|
      next if keyword.blank?

      array += User.name_or_introduction_like(keyword)
    end.uniq
    array
  end

  def groups
    array = []
    @keywords.each do |keyword|
      next if keyword.blank?

      array += Group.includes(:owner).name_or_introduction_like(keyword)
    end.uniq
    array
  end

  def posts
    array = []
    @keywords.each do |keyword|
      next if keyword.blank?

      array += Post.includes(:user, :group).title_or_body_like(keyword)
    end.uniq
    array
  end
end
