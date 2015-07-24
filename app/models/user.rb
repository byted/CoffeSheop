class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :crypted_password, :email, :failed_login_count, :last_login_at, :last_request_at, :level, :login, :login_count, :password_salt, :persistence_token, :emptypw, :balance
  has_many :histories, :dependent => :delete_all

  validates :password, :password_confirmation, numericality: { only_integer: true, allow_blank: true }
  validates :level, presence: true

  acts_as_authentic do |config|
  	config.merge_validates_length_of_password_field_options minimum:4
  end
  
  def self.outstanding_payments
  	amount = 0
  	User.where("balance < 0").each {|u| amount += u.balance}
  	return -amount
  end

  def pay(cart)
  	ret = {bonus_points_used: 0, money_saved: 0, to_pay: 0, products: []}
  	cart.items_in_cart.each do | item |  		
    	quantity_to_pay = item.quantity
    	if item.product.name == "Coffee"
    		diff = item.quantity - self.bonus_points
    		if diff >= 0
    			quantity_to_pay = diff
    			self.bonus_points = 0
    		else
    			quantity_to_pay = 0
    			self.bonus_points = -diff
    		end
    		ret[:bonus_points_used] += item.quantity - quantity_to_pay
    		ret[:money_saved] += ret[:bonus_points_used] * item.product.price
    	end
    	
    	item.product.reduce_stock_by item.quantity
    	ret[:to_pay] += item.product.price * quantity_to_pay
    	
    	#add to history
    	self.histories << History.new(user_id: self.id, category: "buy", name: item.product.name, quantity: item.quantity, total: -(item.product.price * quantity_to_pay), bonus_points_used: (item.quantity - quantity_to_pay))
			ret[:products] << {name: item.product.name, quantity: item.quantity, price: item.product.price} 	
    end

    self.balance -= ret[:to_pay]  
    return ret
  end
  
  
  def add_balance_change_to_history(change)
  	cat = "pay-out"
  	cat = "deposit" if change >= 0
  	self.histories << History.new(user_id: self.id, category: cat, name: cat, quantity: 1, total: change)
  end
end
