require "csv"

CSV.generate do |csv|
  column_names = %w[投稿者 タイトル 投稿内容 Youtube_URL いいねの数 コメントの数 投稿時間] # %w()空白で区切りを認識。カンマがいらない
  csv << column_names
  column_values = [
    @post.user.name,
    @post.title,
    @post.body,
    @post.youtube_url,
    @post.likes.count,
    @post.comments.count,
    @post.created_at
  ]
  # csv << column_values　で表の行に入る値を定義
  csv << column_values
end
