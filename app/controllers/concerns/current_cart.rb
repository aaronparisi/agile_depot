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

# questions I'm having at this point:

# 1. how does a private module method get called?  My understanding is that private
# methods can only be called by an instance of the class who defines them,
# but a module can't be instantiated, so who calls the method?
# I'm guessing some class 'extends' the module or something?

# 2. we are about to generate a scaffold for a line item in the cart,
# which would link together a product and a cart.  the book says 
# product:references and cart:belongs_to
# i.e. a line item references a product and belongs_to a cart
# What's the difference between references and belongs_to?