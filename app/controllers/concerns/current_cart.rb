module CurrentCart
  private

  def set_cart
    # since there is only 1 session, we can directly access the only instance
    # of :cart_id within the session data structure
    # we use that cart_id to find the Cart in the database whose id matches
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    # sets @cart to a new instance of Cart and populates the session hash
    # note that at the termination of this method,
    # there is now a corresponding row in the database, but it's empty??
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
  
end