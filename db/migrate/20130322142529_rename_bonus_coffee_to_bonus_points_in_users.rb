class RenameBonusCoffeeToBonusPointsInUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :bonus_coffee, :bonus_points
  end

end
