require 'test_helper'

class User::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_posts_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_posts_destroy_url
    assert_response :success
  end

end
