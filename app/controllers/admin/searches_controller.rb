class Admin::SearchesController < ApplicationController
    @keyword = params[:word]
  def search
    @users = User.looks(params[:word]).order(created_at: :desc).page(params[:page]).per(12)
  end
end
