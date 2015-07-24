require 'test_helper'

class ItemsInCartsControllerTest < ActionController::TestCase

  setup :activate_authlogic # run before tests are executed
  setup do
    @request.env['HTTP_REFERER'] = root_url
    @product = Product.create(name: "test", price: 1)
    @items_in_carts = items_in_carts(:one)
  end



  test "should create items_in_cart" do
    as_user
    assert_difference('ItemsInCart.count') do
      post :create, product_id: @product.id 
    end
  end

  test "should not create items_in_cart when not logged in" do
    assert_difference('ItemsInCart.count', 0) do
      post :create, product_id: @product.id
    end
    assert_redirected_to root_url
  end

  test "should destroy items_in_cart" do
    as_user
    #add
    post :create, product_id: @product.id
    #try to delete it
    assert_difference('ItemsInCart.count', -1) do
      delete :destroy, id: @product.id
    end
  end
end
