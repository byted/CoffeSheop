class Order < ActiveRecord::Base
  attr_accessible :user

  has_many :items_in_cart, dependent: :destroy
  has_many :products, through: :items_in_cart
  validates :user, presence: true

  def add_items_from_cart(cart)
  	cart.items_in_cart.each do |item|
  		item.cart_id = nil
  		items_in_cart << item
      item.product.reduce_stock(item.quantity * item.product.amount_per_unit)
  	end
  end

  def total_price
		total_price_without_bonus_points - money_saved_with_bonus_points
	end

  def total_price_without_bonus_points
    items_in_cart.to_a.sum { |item| item.total_price }
  end

  def money_saved_with_bonus_points
    self.bonus_points_used * Product.find_by_name("Coffee").price
  end

	def total_items
		items_in_cart.to_a.sum { |item| item.quantity }
	end

  def coffees_in_order
    coffee_id = Product.find_by_name("Coffee").id
    #coffee = ItemsInCart.where("product_id == ? AND order_id == ?",coffee_id, self[:id]).first
    #logger.error "=========>self.id: #{self[:id]}"
    coffee = items_in_cart.find_by_product_id(coffee_id)
    if coffee
      coffees_bought = coffee.quantity
    else
      coffees_bought = 0
    end
    return coffees_bought
  end
end
