class DropUsergroupTable < ActiveRecord::Migration
  def up
    drop_table :usergroups
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
