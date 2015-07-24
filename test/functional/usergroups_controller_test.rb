require 'test_helper'

class UsergroupsControllerTest < ActionController::TestCase

  setup :activate_authlogic # run before tests are executed
  setup do
    @usergroup = usergroups(:one)
    user = User.create!(login: "Admin", email: "web@web.de", level: 1)
    UserSession.create(user) # logs a user in
  end

  test "normal user should not get index" do
    #overwrite user to be non-admin
    user = User.create!(login: "User", email: "web2@web.de", level: 2)
    UserSession.create(user) # logs a user in

    get :index
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usergroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usergroup" do
    assert_difference('Usergroup.count') do
      post :create, usergroup: { name: "new group" }
    end

    assert_redirected_to usergroup_path(assigns(:usergroup))
  end

  test "should show usergroup" do
    get :show, id: @usergroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usergroup
    assert_response :success
  end

  test "should update usergroup" do
    put :update, id: @usergroup, usergroup: { name: @usergroup.name }
    assert_redirected_to usergroup_path(assigns(:usergroup))
  end

  test "should destroy usergroup" do
    assert_difference('Usergroup.count', -1) do
      delete :destroy, id: @usergroup
    end

    assert_redirected_to usergroups_path
  end
end
