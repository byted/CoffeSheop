class ItemsInCart < ActiveRecord::Base
  attr_accessible :cart_id, :product_id
  # no item in cart can exist without an existing product and cart
  # read: belongs_to <=> foreign key
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def total_price
  	product.price * quantity
  end

  def get_all_products_for(order)
  	Items_in_cart.find(:order_id == order.id)
  end
end
