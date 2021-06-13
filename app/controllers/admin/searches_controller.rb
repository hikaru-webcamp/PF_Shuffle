class Admin::SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    @users = User.looks(params[:word]).order(created_at: :desc)
  end
  
end
