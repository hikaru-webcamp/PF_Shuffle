class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :owner_groups, class_name: "Group", dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # ====================自分がフォローしているユーザーとの関連 ===================================
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, inverse_of: "follower", dependent: :destroy
  has_many :following_users, through: :active_relationships,  source: :followed
  # ====================自分がフォローされるユーザーとの関連 ===================================
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, inverse_of: "followed", dependent: :destroy
  has_many :follower_users,  through: :passive_relationships, source: :follower

  # attachmentメソッドで、refileが指定カラムにアクセス可能にする
  attachment :profile_image, destroy: false

  # バリデーションの記述(空白禁止と文字制限)
  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :email, presence: true
  validates :introduction, length: { maximum: 160 } # ツイッターの自己紹介文は160文字

  # 退会したユーザーはログイン出来ない仕様にする。
  def active_for_authentication?
    super && is_deleted == false
  end

  def follow(user)
    return if self == user || following_users.include?(user)

    Relationship.create(follower_id: id, followed_id: user.id)
  end

  def unfollow(user)
    return if following_users.exclude?(user)

    relationship = Relationship.find_by(follower_id: id, followed_id: user.id)
    relationship.destroy
  end

  # フォロー用メソッド
  def followed_by?(user)
    follower_users.include?(user)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end
end
