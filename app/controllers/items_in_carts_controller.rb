class ItemsInCartsController < ApplicationController
  before_filter :authorize

  # POST /items_in_carts
  # POST /items_in_carts.json
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @items_in_cart = @cart.add_product(product.id)

    respond_to do |format|
      if @items_in_cart.save
        format.html { redirect_to :back, notice: 'Items in cart was successfully created.' }
        format.js { 
          @current_item = @items_in_cart
          @balance_would_be = current_user.balance - @cart.total_price
        }
        format.json { render json: @items_in_cart, status: :created, location: @items_in_cart }
      else
        format.html { render action: "new" }
        format.json { render json: @items_in_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items_in_carts/1
  # DELETE /items_in_carts/1.json
  def destroy
    @cart = current_cart
    product = Product.find(params[:id])
    @items_in_cart = @cart.remove_product(product.id)

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Items in cart was successfully removed.' }
      format.js { @current_item = @items_in_cart}
      format.json { render json: @items_in_cart, status: :created, location: @items_in_cart }
    end
  end
end
