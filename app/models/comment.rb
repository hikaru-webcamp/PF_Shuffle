class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  #バリデーションの記述(空白禁止と文字制限)
  validates :body, presence: true, length: {maximum: 200}
end
