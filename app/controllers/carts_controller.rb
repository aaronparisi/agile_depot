class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    # notice here that @cart is set via set_cart, which gets the cart
    # via the cart_id variable in PARAMS, not the session
    @line_items = @cart.line_items
    # if @line_items.empty?
    #   redirect_to store_index_path, notice: "Your cart is empty"
    # end
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # def empty
  #   @
  # end
  

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    # views/carts/show redirects here with @cart
    # CartsController#show is called by LineItemsController#create, with
    # @line_item.cart, which puts the proper cart's id in params
    # CartsController#show thus sets @cart via that value in params
    # so the button in views/carts/show refers to THIS @cart, i.e.
    # the one whose id matches the cart_id in the line_item created when
    # adding an item to the cart (and that line item derived a cart from CurrentCart)
    # ? how could someone make a delete request to cart_path with some random id,
    # ? as opposed to the id given to the cart's show view?
    @cart.destroy if @cart.id == session[:cart_id]
    # ? what if they are not equal?  Do we still set the cart to nil?
    # ? doesn't that leave a cart object in the database??
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to store_index_url, notice: 'Cart was successfully emptied.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_index_url, notice: 'Invalid cart'
      # puts "before render"
      # @products = Product.order(:title)
      # @visit_count = session[:visit_count]
      # @page_title = "Your Pragmatic Catalog"
      # render 'store/index'
      # puts "after render"
    end
    
end
