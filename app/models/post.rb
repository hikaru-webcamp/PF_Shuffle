class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :likes, dependent: :destroy, counter_cache: true
  has_many :comments, dependent: :destroy, counter_cache: true

  # イイネ用メソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # バリデーションの記述(空白禁止と文字制限)
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 500 }

  # ランキング用メソッド
  def self.all_post_ranks
    # 投稿の番号(post_id)が同じものにグループを分ける
    # pluckで:post_idカラムのみを数字で取り出すように指定。
    # ポストのランキング limirで表示する最大数を指定する
    find(Like.group(:post_id).order("count(post_id) desc").limit(6).pluck(:post_id))
  end

  def self.title_or_body_like(value)
    where("title LIKE(?) OR body LIKE(?)", "%#{value}%", "%#{value}%").order(created_at: :desc)
  end
end
