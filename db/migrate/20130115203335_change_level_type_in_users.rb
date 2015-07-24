class ChangeLevelTypeInUsers < ActiveRecord::Migration
  def up
  	change_column(:users, :level, :integer)
  end

  def down
    change_column(:users, :level, :string)
  end
end
