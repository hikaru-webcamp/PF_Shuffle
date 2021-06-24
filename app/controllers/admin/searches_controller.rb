class Admin::SearchesController < ApplicationController
  def search
    @keyword = params[:word]
    @users = User.looks(params[:word]).order(created_at: :desc).page(params[:page]).per(12)
  end
end
