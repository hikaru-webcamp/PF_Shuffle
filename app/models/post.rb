class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # イイネ用メソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # バリデーションの記述(空白禁止と文字制限)
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 500 }
  
  # 検索方法分岐 メソッド定義してコントローラー側で呼び出し
  # 検索方法は、部分一致で定義
  def self.looks(word)
    return none if word.blank?
      @post = Post.where("title LIKE? OR body LIKE?", "%#{word}%", "%#{word}%")  
  end  
end
