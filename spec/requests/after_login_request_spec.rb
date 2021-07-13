require "rails_helper"

describe " ユーザログイン後のリクエストテスト", type: :request do
  let!(:user) { create(:user) }
  let!(:owner) { create(:user) }
  let!(:group) { create(:group, owner_id: owner.id) }
  let!(:post) { create(:post, user: owner, group: group) }

  describe "Homes" do
    context "GET /" do
      it "トップページの表示が取得できること" do
        get root_path # HTTPリクエストの送信
        expect(response).to have_http_status(200) # HTTPレスポンスのステータスコードが200
        # puts response.body #ログでhtmlの情報出力したい時
      end
    end

    context "GET /search" do
      it "検索結果ページの表示が取得できること" do
        get search_path params: { word: "test" }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "Groups" do
    context "GET /groups" do
      it "グループ一覧ページの表示が取得できること" do
        get groups_path
        expect(response).to have_http_status(200)
      end
    end
    context "GET /groups/:id" do
      it "グループ詳細ページの表示が取得できること" do
        get groups_path(group)
        expect(response).to have_http_status(200)
      end
    end
    context "GET /groups/:id/posts" do
      it "グループ投稿一覧ページの表示が取得できること" do
        sign_in user
        get group_posts_path(group)
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "Groups 投稿詳細" do
    before do
      sign_in user
      @group_user = create(:group_user)
      @group = @group_user.group.id
    end
    context "GET /groups/:id/posts/new" do
      it "新規投稿の表示が取得できること" do
        get new_group_post_path(@group)
        expect(response).to have_http_status(200)
      end
    end
    context "GET /groups/:id/posts/:id" do
      it "投稿の詳細表示が取得できること" do
        get group_post_path(@group, post)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "Users" do
    before do
      sign_in user
    end

    context "GET /users" do
      it "会員一覧ページの表示が取得できること" do
        get users_path
        expect(response).to have_http_status(200)
      end
    end
    context "GET /users/:id" do
      it "ユーザープロフィールの表示" do
        get users_path(user)
        expect(response).to have_http_status(200)
      end
    end
    context "GET /users/:id/edit" do
      it "ユーザー編集画面の表示" do
        get edit_user_path(user)
        expect(response).to have_http_status(200)
      end
    end
    context "GET /users/:id/group_in" do
      it "ユーザー加入グループの表示" do
        get user_group_in_path(user)
        expect(response).to have_http_status(200)
      end
    end
    context "GET /users/:id/post_index" do
      it "ユーザー投稿一覧の表示" do
        get user_post_index_path(user)
        expect(response).to have_http_status(200)
      end
    end
    context "GET /users/:id/relationships/following" do
      it "ユーザーのフォロー中一覧表示" do
        get following_user_relationships_path(user)
        expect(response).to have_http_status(200)
      end
    end
    context "GET /users/:id/relationships/follower" do
      it "ユーザーのフォロー 一覧表示" do
        get follower_user_relationships_path(user)
        expect(response).to have_http_status(200)
      end
    end
  end
end
