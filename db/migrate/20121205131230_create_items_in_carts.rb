class CreateItemsInCarts < ActiveRecord::Migration
  def change
    create_table :items_in_carts do |t|
      t.integer :product_id
      t.integer :cart_id

      t.timestamps
    end
  end
end
