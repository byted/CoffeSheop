class ChangeBalanceTypeFromUsers < ActiveRecord::Migration
  def up
  	change_column :users, :balance, :decimal, :precision => 8, :scale => 2
  end

  def down
  	change_column :users, :balance, :integer
  end
end
