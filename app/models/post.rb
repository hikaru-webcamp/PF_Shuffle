class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  #バリデーションの記述(空白禁止と文字制限)
  validates :comment, presence: true, length: {maximum: 200}
end
