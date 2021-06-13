class Group < ApplicationRecord
    has_many :group_users
    has_many :users, through: :group_users
    has_many :posts
    accepts_nested_attributes_for :group_users

    attachment :image
  #バリデーションの記述(空白禁止と文字制限)
    validates :name, presence: true, length: {maximum: 20, minimum: 2} 
    validates :introduction, presence: true, length: {maximum: 200} 
    
    # 検索方法分岐 メソッド定義してコントローラー側で呼び出し
    #検索部分一致で定義
  def self.looks(word)
    where(["name LIKE?", "%#{word}%"])
  end

end

#accepts_nested_attributes_forは
#他のモデルを一括で更新、保存できるようにするもの。
#groupを保存するのと同時にgroup_usersを更新できるようにしています。