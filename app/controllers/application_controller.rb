class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_cart, :is_admin, :coffee_machine_needs_to_be_cleaned?

  COLORS = %w( blueLight pink green orange greenLight greenDark pinkDark blueDark red yellow orangeDark purple )

  private
    def coffee_machine_needs_to_be_cleaned?
      return true if Settings.coffees_since_last_clean_up.to_i > Settings['gui.cleaning_intervall'].to_i
      return false
    end

  	def current_cart
  		Cart.find(session[:cart_id])
  	rescue ActiveRecord::RecordNotFound
  		cart = Cart.create
  		session[:cart_id] = cart.id
  		#return
  		cart
  	end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def is_admin
      current_user.level == "Admin"
    end

    def authorize
      unless current_user
        redirect_to root_url
        false
      end
    end

    def authorize_admin
      unless current_user && is_admin
        redirect_to root_url
        return false
      end
      if !session[:pin_entered]
        redirect_to :ask_pin
        false
      end
    end

    def if_current_user_or_admin user_id, &block
      if user_id == current_user.id || is_admin
        block
      else
        redirect_to root_url, alert: "Unauthorized Access"
      end
    end
end
