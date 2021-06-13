class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :group_users       
  has_many :groups, through: :group_users
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  #attachmentメソッドで、refileが指定カラムにアクセス可能にする
  attachment :profile_image, destroy: false

  #バリデーションの記述(空白禁止と文字制限)
  validates :name, presence: true, length: {maximum: 20, minimum: 2} 
  validates :email, presence: true
  validates :introduction, length: {maximum: 160} #ツイッターの自己紹介文は160文字

  #退会したユーザーはログイン出来ない仕様にする。
  def active_for_authentication?
    super && self.is_deleted == false
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
