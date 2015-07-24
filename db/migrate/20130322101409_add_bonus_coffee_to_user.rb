class AddBonusCoffeeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :bonus_coffee, :integer, default: 0
  end
end
