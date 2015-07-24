class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.integer :level
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count,   :default => 0
      t.integer :failed_login_count,   :default => 0
      t.datetime :last_login_at
      t.datetime :last_request_at

      t.timestamps
    end
  end
end
