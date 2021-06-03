require 'test_helper'

class User::GroupUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_group_users_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_group_users_destroy_url
    assert_response :success
  end

end
