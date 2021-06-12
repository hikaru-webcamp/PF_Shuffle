class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  # イイネ用メソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  
  #バリデーションの記述(空白禁止と文字制限)
  validates :title, presence: true, length: {maximum: 30} 
  validates :body, presence: true, length: {maximum: 200}
end
