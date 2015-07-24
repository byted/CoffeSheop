class CreateHistory < ActiveRecord::Migration
  def up
    create_table :histories do |t|
      t.string :category, :null => false
      t.string :name, :null => false
      t.decimal :total, :precision => 8, :scale => 2
      t.integer :quantity, :default => 1
      t.integer :user_id, :null => false
      t.integer :bonus_points_used, :default => 0

      t.timestamps
    end
    
    Order.all.each do |o|
    	ItemsInCart.find_all_by_order_id(o).each do |i|
    		i.product.name == "Coffee" ? bpu = o.bonus_points_used : bpu = 0
    		tmp = History.new(user_id: o.user, category: "buy", name: i.product.name, quantity: i.quantity, total: -(i.product.price*(i.quantity-bpu)), bonus_points_used: bpu, created_at: o.created_at, updated_at: o.updated_at)
    		tmp.save!
    	end
    end
  end
  
  def down
  	drop_table :histories
  end
end
