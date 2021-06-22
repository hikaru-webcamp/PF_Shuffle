class User::SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:word]).order(created_at: :desc).page(params[:page]).per(12)
    elsif @range == "Group"
      @groups = Group.looks(params[:word]).order(created_at: :desc).page(params[:page]).per(12)
    else
      @groups = Group.all.includes(:post)
      @posts = Post.looks(params[:word]).includes([:group]).order(created_at: :desc).page(params[:page]).per(12)
    end
  end
end
