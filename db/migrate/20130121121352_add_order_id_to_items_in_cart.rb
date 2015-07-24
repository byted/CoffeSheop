class AddOrderIdToItemsInCart < ActiveRecord::Migration
  def change
    add_column :items_in_carts, :order_id, :integer
  end
end
