require 'byebug'

class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create, :index]
  before_action :ensure_cart_not_empty, only: :new
  before_action :set_order, only: [:show, :edit, :update, :destroy, :ship]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    #@payTypes = PayType.all
    respond_to do |format|
      format.html { redirect_to store_index_path}
      format.js
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart) # an Order instance method
    
    respond_to do |format|
      if @order.save
        @products = Product.all
        set_cart
        Cart.destroy(session[:cart_id])  # we are NOT issuing a destory request to carts_path....
        OrderMailer.received(@order).deliver_later
        format.html { redirect_to store_index_url, notice: 'Thank you for your order.' }
        format.js { flash.now[:notice] = 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ship
    # add date to ship_date column
    @order.ship_date = Date.today

    # send shipped e mail
    if @order.save
      OrderMailer.shipped(@order).deliver_later
      respond_to do |format|
        @products = Product.all
        format.js
      end      
    end

  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type_id)
    end

    def ensure_cart_not_empty
      if @cart.line_items.empty?
        redirect_to store_index_url, notice: "Your cart is empty"
      end
    end
    
end
