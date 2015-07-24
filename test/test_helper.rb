ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "authlogic/test_case"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def as_admin
  	admin = User.create!(login: "Admin", email: "admin@example.de", level: 1)
  	UserSession.create(admin) # logs a admin in
    return admin
  end

  def as_user
  	user = User.create!(login: "Normal", email: "user@example.de", level: 2)
  	UserSession.create(user) # logs a user in
    return user
  end

  def logged_out
  	UserSession.find.destroy
  end
end
