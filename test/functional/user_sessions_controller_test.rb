require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  setup :activate_authlogic # run before tests are executed
  setup do
    user_no_pw = User.create!(login: "NoPw", email: "user@example.de", level: 2, emptypw: true)
    user_w = User.create!(login: "WithPw", email: "userpw@example.de", level: 2, password: "1234", emptypw: false)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_session_with_pw" do
    post :create, user_session: { password: "1234", login: "WithPw" }
    assert_not_nil UserSession.find
    assert_redirected_to store_path
  end

  test "should not create user_session with wrong pw" do
    post :create, user_session: { password: "4321", login: "WithPw" }
    assert_redirected_to root_url
    assert_not_nil flash[:alert]
  end

  test "should not create user_session with empty pw if user has pw" do
    post :create, user_session: { password: "4321", login: "WithPw" }
    assert_redirected_to root_url
    assert_not_nil flash[:alert]
  end

  test "should create user_session_no_pw" do
    post :create, user_session: { password: "", login: "NoPw" }
    assert_not_nil UserSession.find
    assert_redirected_to store_path
  end

  test "should destroy user_session" do
    delete :destroy, id: @user_session
    assert_nil UserSession.find
    assert_redirected_to root_url
  end
end
