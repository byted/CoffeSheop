class CreateCleanings < ActiveRecord::Migration
  def change
    create_table :cleanings do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
