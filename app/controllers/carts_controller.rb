class CartsController < ApplicationController

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_url }
      format.js {}
      format.json { head :no_content }
    end
  end

  def checkout
    if current_cart.items_in_cart.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end

    cart = current_cart
    details = current_user.pay cart
    
    # saving details for invoice
    flash[:var] = {
    	user: current_user.login,
    	new_balance: current_user.balance,
    	full_price: cart.total_price,
    	to_pay: details[:to_pay],
    	total_items: cart.total_items,
    	money_saved: details[:money_saved],
    	products: details[:products]
    }
    
    #logout user
    current_user_session.destroy
    #increase cleaning counter
    coffee_count = Settings.coffees_since_last_clean_up.to_i
    Settings.coffees_since_last_clean_up = coffee_count + cart.number_of_coffees    
    

    respond_to do |format|
      if current_user.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to invoice_path  }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { redirect_to store_url, notice: 'Could not save!' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def invoice
  	unless flash[:var].nil?
  		@details = flash[:var]
  	else
  		redirect_to root_path
  	end
  end
end


