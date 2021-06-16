class User::SearchesController < ApplicationController
  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.looks(params[:word]).order(created_at: :desc).page(params[:page]).per(8)
    else
      @groups = Group.looks(params[:word]).order(created_at: :desc).page(params[:page]).per(9)
    end
    
  end
end
