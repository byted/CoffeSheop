class Cart < ActiveRecord::Base
  # a cart can have multiple items in it. 
  # additionally, the items depend on the cart.
  # if the cart is destroyed, so are all items in it.
  has_many :items_in_cart, dependent: :destroy
	
	def add_product(product_id)
		item = items_in_cart.find_by_product_id(product_id)
		if item
			item.increment!(:quantity)
		else
			item = items_in_cart.build(product_id: product_id)
		end
		return item
	end

	def remove_product(product_id)
		item = items_in_cart.find_by_product_id(product_id)
		# item is in cart
		if item
			# and more than one
			if item.quantity > 1
				item.decrement!(:quantity)
				return item
			#exactly one
			else
				item.destroy
				return nil
			end
		end
	end

	def total_price
		items_in_cart.to_a.sum { |item| item.total_price }
	end

	def total_items
		items_in_cart.to_a.sum { |item| item.quantity }
	end

	def quantityOf(product_id)
		item = items_in_cart.find_by_product_id(product_id)
		if item
			return item.quantity
		else
			return 0
		end
	end
	
	def number_of_coffees
		quantityOf(Product.find_by_name("Coffee").id)
	end
end
