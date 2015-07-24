class AddBonusPointsUsedToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :bonus_points_used, :integer, default: 0
  end
end
