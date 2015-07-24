class History < ActiveRecord::Base
  attr_accessible :quantity, :name, :total, :category, :user_id, :bonus_points_used, :created_at, :updated_at 
  belongs_to :user
end
