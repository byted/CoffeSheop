class StoreController < ApplicationController
	before_filter :authorize

  def index
  	@cart = current_cart
  	@products = Product.order(:name)
  	@items_in_cart = ItemsInCart.where(:cart_id == current_cart)
  	@users = User.order(:login)
  	@user_session = UserSession.new
  end
end 
