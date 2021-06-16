class User::HomesController < ApplicationController
  def top
     @all_ranks = Group.where(id: GroupUser.group(:group_id).order('count(group_id) desc').limit(3).pluck(:group_id))
     @admins = Admin.first(3)
  end
end
