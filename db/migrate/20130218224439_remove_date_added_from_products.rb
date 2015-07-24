class RemoveDateAddedFromProducts < ActiveRecord::Migration
  def up
  	remove_column(:products, :dateAdded)
  end

  def down
  end
end
