require 'rails_helper'

describe ' ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:owner) { create(:user) }
  let!(:group) { create(:group, owner_id: owner.id) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『before_login_spec』でテスト済み。' do
      subject { current_path }

      it 'ホームを押すと、TOPページに遷移する' do
        click_on 'ホーム'
        is_expected.to eq '/'
      end
      it 'マイページを押すと、会員詳細ページに遷移する' do
        click_on 'マイページ'
        is_expected.to eq '/users/' + user.id.to_s
      end
      it '会員一覧を押すと、会員一覧ページに遷移する' do
        click_on '会員一覧'
        is_expected.to eq users_path
      end
      it 'グループ一覧を押すと、会員一覧ページに遷移する' do
        click_on 'グループ一覧'
        is_expected.to eq groups_path
      end
    end
  end

  describe '会員一覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示内容の確認' do
      it '「User List」と表示される' do
        expect(page).to have_content 'User List'
      end
      it '会員一覧画面のURLが正しい' do
        expect(current_path).to eq '/users'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
        expect(page).to have_link '', href: user_path(owner)
      end
      it '自分と他人の名前が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content owner.name
      end
      it '自分と他人の自己紹介文が表示される' do
        expect(page).to have_content user.introduction
        expect(page).to have_content owner.introduction
      end
      it '自分と他人のグループ数が表示される' do
        expect(page).to have_content user.groups.size
        expect(page).to have_content owner.groups.size
      end
      it '自分と他人のフォロー数が表示される' do
        expect(page).to have_content user.following_users.size
        expect(page).to have_content owner.following_users.size
      end
      it '自分と他人のフォロワー数が表示される' do
        expect(page).to have_content user.follower_users.size
        expect(page).to have_content owner.follower_users.size
      end
      it '無限スクロールのクラスは存在するか' do
        expect(page).to have_selector '.jscroll, scroll-list, jscroll-pagination'
      end
    end
  end

  describe '会員詳細画面のテスト' do
    before do
      visit user_path(owner)
    end

    context '表示内容の確認' do
      it '会員詳細画面のURLが正しい' do
        expect(current_path).to eq '/users/' + owner.id.to_s
      end
      it '自分の名前が表示される' do
        expect(page).to have_content owner.name
      end
      it '自分の自己紹介文が表示される' do
        expect(page).to have_content owner.introduction
      end
      it '自分のグループ数が表示される' do
        expect(page).to have_content owner.groups.size
      end
      it '自分のフォロー数が表示される' do
        expect(page).to have_content owner.following_users.size
      end
      it '自分のフォロワー数が表示される' do
        expect(page).to have_content owner.follower_users.size
      end
      it 'グループのリンクが存在するか' do
        expect(page).to have_link "グループ"
      end
      it '投稿一覧のリンクが存在するか' do
        expect(page).to have_link "投稿一覧"
      end
      it 'フォローリンクが存在するか' do
        expect(page).to have_link "フォロー"
      end
      it 'フォロー中のリンクが存在するか' do
        expect(page).to have_link "フォロー中"
      end
    end
    context 'フォローの確認' do
      before do
        click_on 'フォロー'
      end
      it 'フォロー中のリンクが存在するか' do
        expect(page).to have_link "フォロー中"
      end
      it 'フォローのリンクが存在するか' do
        click_on 'フォロー中'
        expect(page).to have_link "フォロー"
      end
    end
  end

  describe 'グループ一覧画面のテスト' do
    before do
      visit groups_path
    end

    context '表示内容の確認' do
      it '「Group List」と表示される' do
        expect(page).to have_content 'Group List'
      end
      it 'グループ一覧画面のURLが正しい' do
        expect(current_path).to eq '/groups'
      end
      it 'グループの画像のリンク先が正しい' do
        expect(page).to have_link '', href: group_path(group)
      end
      it 'グループの名前が表示される' do
        expect(page).to have_content group.name
      end
      it 'グループの自己紹介文が表示される' do
        expect(page).to have_content group.introduction
      end
      it 'グループに加入したメンバー数が表示される' do
        expect(page).to have_content group.users.size
      end
      it 'グループの作成ボタンが表示される' do
        expect(page).to have_button 'グループを作成する'
      end
      it '無限スクロールのクラスは存在するか' do
        expect(page).to have_selector '.jscroll, scroll-list, jscroll-pagination'
      end
    end
  end

  describe 'グループ詳細画面のテスト' do
    before do
      visit group_path(group)
    end

    context '表示内容の確認' do
      it 'グループ詳細画面のURLが正しい' do
        expect(current_path).to eq '/groups/' + group.id.to_s
      end
      it 'グループの名前が表示される' do
        expect(page).to have_content group.name
      end
      it 'グループの自己紹介文が表示される' do
        expect(page).to have_content group.introduction
      end
      it 'グループを作った人の名前が表示される' do
        expect(page).to have_content group.owner.name
      end
      it '自分のグループのメンバー数が表示される' do
        expect(page).to have_content owner.groups.size
      end
      it 'メンバーのリンクが存在するか' do
        expect(page).to have_link "メンバー"
      end
      it '投稿一覧のリンクが存在するか' do
        expect(page).to have_link "投稿一覧"
      end
      it 'グループ加入リンクが存在するか' do
        expect(page).to have_link "グループ加入"
      end
    end

    context 'グループ加入と脱退の確認' do
      before do
        click_on 'グループ加入'
      end
      it 'グループ脱退のリンクが存在するか' do
        expect(page).to have_link "グループ脱退"
      end
      it '投稿のリンクが存在するか' do
        expect(page).to have_link "投稿"
      end
      it 'グループ加入のリンクが存在するか' do
        click_on 'グループ脱退'
        expect(page).to have_link "グループ加入"
      end
    end
  end
end
