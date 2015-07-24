class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user

      t.timestamps
    end
  end
end
