class AddInStockToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :in_stock, :integer, default: 0
  end
end
