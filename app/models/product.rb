class Product < ActiveRecord::Base
  attr_accessible :categorie, :description, :name, :price, :picture, :threshold, :in_stock, :amount_per_unit
  # multiple carts can contain the same product
  has_many :items_in_cart

  validates :name, :price, :in_stock, :threshold, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0} 
  validates :in_stock, :threshold, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :name, uniqueness: true
  # prevent the deletion of an product which is already in a cart
  before_destroy :ensure_not_referenced_by_any_items_in_cart

  # are there any items in a cart that reference this product?
  def ensure_not_referenced_by_any_items_in_cart
  	if items_in_cart.empty?
  		return true
  	else
  		errors.add(:base, 'Product still in a Cart')
  		return false
  	end
  end

  def reduce_stock_by(quantity)
    update_attribute(:in_stock, in_stock - quantity)
  end

  def is_running_low?
    in_stock <= threshold
  end

  def self.stock_full?
    Product.all.each { |product|
      if product.is_running_low?
        return false
      end
    }
    true
  end
  
  def self.price_of_coffee
  	return (Product.find_by_name "Coffee").price
  end
end
