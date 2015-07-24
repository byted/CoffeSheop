require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  setup :activate_authlogic # run before tests are executed
  setup do
    @product = products(:one)
    as_admin
  end

  test "normal user should not get index" do
    #overwrite user to be non-admin
    as_user

    get :index
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { name: "new", price: 2 }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: { in_stock: @product.in_stock, threshold: @product.threshold, categorie: @product.categorie, amount_per_unit: @product.amount_per_unit, description: @product.description, name: @product.name, price: @product.price }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should get replenish" do
    get :replenish
    assert_response :success
  end

  test "should update in_stock" do
    post :update_stock, id: @product, stock: "1"
    assert_redirected_to admin_path
    assert_equal "Replenished stock for #{@product.name}: #{@product.in_stock + 1} Units available", flash[:notice]
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

end
