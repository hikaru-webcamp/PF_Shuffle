class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", inverse_of: :owner_groups
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :group_users

  attachment :image

  # バリデーションの記述(空白禁止と文字制限)
  validates :name, presence: true, length: { maximum: 50, minimum: 2 }
  validates :introduction, presence: true, length: { maximum: 200 }

  # イイネ用メソッド
  def member_by?(user)
    group_users.where(user_id: user.id).exists?
  end

  # ランキング用メソッド
  def self.all_group_ranks
    # グループのランキング
    find(GroupUser.group(:group_id).order("count(group_id) desc").limit(6).pluck(:group_id))
  end
end
