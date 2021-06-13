class User::SearchesController < ApplicationController
  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.looks(params[:search], params[:word]).order(created_at: :desc)
    else
      @groups = Group.looks(params[:search], params[:word]).order(created_at: :desc)
    end
    
  end
end
