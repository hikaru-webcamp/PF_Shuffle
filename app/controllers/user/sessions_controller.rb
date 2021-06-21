# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |gest|
      gest.name = "ゲスト"
      gest.password = SecureRandom.urlsafe_base64(6)
    end
    sign_in user
    redirect_to groups_path, notice: 'ゲストユーザーとしてログインしました'
  end
  # find_or_create_by!で条件を指定して初めemailの1件を取得し、指定のemailが1件もなければ作成
  # SecureRandom.urlsafe_base64(6)でランダムの文字列６文字を生成

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    groups_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    root_path
  end
end
