class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
#ユニーク制約scopeで1人のユーザーが１つのグループしか入れないよう設定(グループには複数のユーザーが入れる）
  validates :group_id, uniqueness: { scope: :user_id }
end
