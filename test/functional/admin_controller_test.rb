require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  
	setup :activate_authlogic # run before tests are executed
  setup do 
    Settings.test = "foo"
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
  end

  test "normal user should not get settings" do
    as_user
    get :index
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should get settings" do
    as_admin
    get :index
    assert_response :success
  end

  test "should update settings" do
    as_admin
    new_val = "bar"

    post :update_settings, test: new_val 

    assert_equal Settings.test, new_val
    assert_redirected_to admin_settings_path
  end

  test "should not update settings as normal user" do
    as_user    
    new_val = "bar"

    post :update_settings, test: new_val

    assert_not_equal Settings.test, new_val
    assert_redirected_to root_url
  end

end
