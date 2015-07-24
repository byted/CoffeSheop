class AddThresholdToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :threshold, :integer, default: 0
  end
end
