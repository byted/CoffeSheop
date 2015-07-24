class AddEmptypwToUsers < ActiveRecord::Migration
  def change
    add_column :users, :emptypw, :boolean, default: false
  end
end
