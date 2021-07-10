require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'ルートパスのURLが正しい' do
        expect(current_path).to eq '/'
      end
      it '指定の値のリンクが存在するか ログイン' do
        expect(page).to have_link "Login"
      end
      it '指定の値のリンクが存在するか 新規登録' do
        expect(page).to have_link "新規会員登録はこちら"
      end
      it '指定の値のリンクが存在するか かんたんログイン' do
        expect(page).to have_link "かんたんログイン"
      end
    end
    
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'ログインボタンを押すと、グループ一覧に遷移する' do
        click_on 'Login'
        is_expected.to eq new_user_session_path
      end
      it '新規会員登録ボタンを押すと、会員登録画面に遷移する' do
        click_on '新規会員登録'
        is_expected.to eq new_user_registration_path
      end
    end    
    
    context 'ヘッダー：ログインしていない場合の表示内容確認' do
      it '指定の値のリンクが存在するか グループリストが表示されている' do
        expect(page).to have_link "グループリスト"
      end
      it '指定の値のリンクが存在するか 管理人ログイン' do
        expect(page).to have_link "管理人ログイン"
      end
      it '指定の値のリンクが存在するか かんたんログイン' do
        expect(page).to have_link "かんたんログイン"
      end
    end
    
    context 'ヘッダー：リンクの内容を確認' do
      subject { current_path }

      it 'グループリストを押すと、グループ一覧に遷移する' do
        click_link 'グループリスト'
        is_expected.to eq groups_path
      end
      it '管理人ログインを押すと、管理人ログイン画面に遷移する' do
        click_link '管理人ログイン'
        is_expected.to eq new_admin_session_path
      end
    end
  end
  
  describe '新規会員登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it '新規会員登録のURLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end
    
    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe '会員ログインのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「会員ログイン」と表示される' do
        expect(page).to have_content '会員ログイン'
      end
      it '「テストアカウントでのログイン」と表示される' do
        expect(page).to have_content 'テストアカウントでのログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、グループ一覧になっている' do
        expect(current_path).to eq groups_path
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it '指定の値のリンクが存在するか ホームが表示されている' do
        expect(page).to have_link "ホーム"
      end
      it '指定の値のリンクが存在するか マイページ' do
        expect(page).to have_link "マイページ"
      end
      it '指定の値のリンクが存在するか 会員一覧' do
        expect(page).to have_link "会員一覧"
      end
      it '指定の値のリンクが存在するか グループ一覧' do
        expect(page).to have_link "グループ一覧"
      end
      it '指定の値のリンクが存在するか ログアウト' do
        expect(page).to have_link "ログアウト"
      end
      it '検索ボタンが表示される' do
        expect(page).to have_button '検索'
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      click_link "ログアウト"
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてログアウトリンクが存在しない' do
        expect(page).not_to have_link nil, href: destroy_user_session_path
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
  
end