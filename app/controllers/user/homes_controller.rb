class User::HomesController < ApplicationController
  def top
     @all_ranks = Group.find(GroupUser.group(:group_id).order('count(group_id) desc').limit(3).pluck(:group_id))
     @users = User.find(1,2,3)
  end
end
