class Group < ApplicationRecord
    has_many :users, through: :group_users
    has_many :group_users
    has_many :posts
    accepts_nested_attributes_for :group_users

    attachment :image
  #バリデーションの記述(空白禁止と文字制限)
    validates :name, presence: true, length: {maximum: 20, minimum: 2} 
    validates :introduction, presence: true, length: {maximum: 200} 
    validates :title, presence: true, length: {maximum: 30} 
    validates :body, presence: true, length: {maximum: 200}
end

#accepts_nested_attributes_forは
#他のモデルを一括で更新、保存できるようにするもの。
#groupを保存するのと同時にgroup_usersを更新できるようにしています。