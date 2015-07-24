class AddQuantityToItemsInCart < ActiveRecord::Migration
  def change
    add_column :items_in_carts, :quantity, :integer, default: 1
  end
end
