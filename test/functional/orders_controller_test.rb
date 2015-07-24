require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  setup :activate_authlogic # run before tests are executed
  setup do
    @user = User.create(login: "Test", email: "web@web.de")
    @cart = Cart.create()
    @product = Product.create(name: "Test", price: 1)
    @items = ItemsInCart.create(cart_id: @cart.id, product_id: @product.id)
    @order = Order.create(user: @user.id)
  end

  test "should get index" do
    as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should not get index as user" do
    as_user
    get :index
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should not create order if cart is empty" do
    as_user
    assert_difference('Order.count', 0) do
      post :create, order: { user: @user.id }
    end
    assert_redirected_to store_url
  end

  test "should create order" do
    as_user
    session[:cart_id] = @cart.id
    assert_difference('Order.count') do
      post :create, order: { user: @user.id }
    end
    assert_response :redirect
  end

  test "should show order" do
    as_admin
    get :show, id: @order
    assert_response :success
    assert_not_nil assigns(:items_in_order)
    assert_not_nil assigns(:order)

  end

  test "should not show order as user" do
    as_user
    get :show, id: @order
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should show invoice" do
    as_user
    get :invoice, id: @order, balance: 300
    assert_response :success
    assert_not_nil assigns(:items_in_order)
    assert_not_nil assigns(:order)
    assert_not_nil assigns(:balance)
  end


  test "should destroy order" do
    as_admin
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
