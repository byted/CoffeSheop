class AdminController < ApplicationController
before_filter :authorize_admin

  def index
		@debt = User.outstanding_payments
  end

  def settings
  	@settings = Settings.all('gui.')
  	@counter = Settings.coffees_since_last_clean_up
  end

  def update_settings
  	Settings.all.each do |key, val|
  		unless params[key].nil?
  			Settings[key] = params[key]
  		end
  	end
    respond_to do |format|
      format.html { redirect_to admin_settings_path, notice: 'Settings were successfully updated.' }
      format.json { head :no_content }
    end
  end
end
