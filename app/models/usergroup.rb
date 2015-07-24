class Usergroup < ActiveRecord::Base
  attr_accessible :name
  has_many :user

  validates :name, uniqueness: true
end
