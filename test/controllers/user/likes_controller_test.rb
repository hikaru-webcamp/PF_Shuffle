require 'test_helper'

class User::LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_likes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_likes_destroy_url
    assert_response :success
  end

end
