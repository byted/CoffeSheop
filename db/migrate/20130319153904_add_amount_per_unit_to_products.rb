class AddAmountPerUnitToProducts < ActiveRecord::Migration
  def change
  	def change
			add_column :products, :amount_per_unit, :integer, default: 1
		end
  end
end
