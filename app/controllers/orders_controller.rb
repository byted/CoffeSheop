class OrdersController < ApplicationController
  before_filter :authorize_admin, :except => [ :invoice, :create ]
  before_filter :authorize, except: :invoice

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @items_in_order = ItemsInCart.where(order_id: @order.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  def invoice
    @order = Order.find(params[:id])
    @balance = params[:balance]
    @items_in_order = ItemsInCart.where(order_id: @order.id)
  end

  # POST /orders
  # POST /orders.json
  def create
    @cart = current_cart
    if @cart.items_in_cart.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end

    @order = Order.new(params[:order])
    # which user was involved
    @order.user = current_user.id
    # add every item from the cart to this order
    @order.add_items_from_cart(current_cart)
    # withdraw money from user
    current_user.pay(@order)
    # remember new balance
    new_balance = current_user.balance
    #logout user
    current_user_session.destroy
    #increase cleaning counter
    coffee_count = Settings.coffees_since_last_clean_up.to_i
    Settings.coffees_since_last_clean_up = coffee_count + @order.coffees_in_order

    respond_to do |format|
      if @order.save && current_user.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to invoice_path(id: @order.id, balance: new_balance)  }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { redirect_to store_url, notice: 'Could not save order!' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])

    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
