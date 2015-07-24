require 'test_helper'

class StoreControllerTest < ActionController::TestCase

	setup :activate_authlogic # run before tests are executed

  test "should get index as user" do
  	as_user
    get :index
    assert_response :success
  end

  test "should get index as admin" do
  	as_admin
    get :index
    assert_response :success
  end

  test "should not get index without login" do
    get :index
    assert_response :redirect
    assert_redirected_to root_url
  end
end
