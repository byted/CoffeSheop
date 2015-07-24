require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup :activate_authlogic # run before tests are executed
  setup do
    @user = users(:one)
    @group = Usergroup.create(name: "test")

  end

  test "normal user should not get index" do
    as_user

    get :index
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should get index" do
    as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    as_admin
    get :new
    assert_response :success
  end

  test "should create user" do
    as_admin
    assert_difference('User.count') do
      post :create, user: { email: "webx@web.de", level: @group.id, login: "Test" }
    end

    assert_redirected_to users_url
  end

  test "should show own user details" do
    current = as_user
    get :show, id: current
    assert_response :success
  end

  test "should not show user details of different users" do
    current = as_user
    get :show, id: @user
    assert_redirected_to root_url
  end

  test "should show user details" do
    current = as_admin
    get :show, id: current
    assert_response :success
  end

  test "should get edit" do
    current = as_user
    get :edit, id: current
    assert_response :success
  end

  test "should update own user details" do
    current = as_user
    put :update, id: current, user: { login: "update", password: "1234", email: "update@web.de" }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not update own balance or level" do
    current = as_user
    assert_difference('current.balance', 0) do
      put :update, id: current, user: { balance: 100 }
    end
    assert_difference('current.level', 0) do
      put :update, id: current, user: { level: 100 }
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not update other users details" do
    current = as_user
    put :update, id: @user, user: { login: "update" }
    assert_redirected_to root_url
  end

  test "should update other users details as admin" do
    current = as_admin
    put :update, id: @user, user: { login: "update", password: "1234", email: "update@web.de", level: @group.id }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not update pw to non-number" do
    current = as_admin
    put :update, id: @user, user: { password: "newPW"}
    assert_response :success
  end

  test "should destroy user" do
    as_admin
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
