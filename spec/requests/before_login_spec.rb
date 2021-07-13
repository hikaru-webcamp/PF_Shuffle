require "rails_helper"

describe "Registrations", type: :request do
  describe "GET /users/sign_up" do
    it "ユーザー登録画面の表示" do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/sign_in" do
    it "会員側ログイン画面の表示" do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /admin/sign_in" do
    it "管理側ログイン画面の表示" do
      get new_admin_session_path
      expect(response).to have_http_status(200)
    end
  end
end
