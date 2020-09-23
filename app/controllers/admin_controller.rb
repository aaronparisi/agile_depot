class AdminController < ApplicationController
  def index
    @order_count = Order.count
    @unshipped = Order.where(ship_date: nil).length
    sesh_id = session[:user_id]
    if sesh_id
      @adminUser = User.find(session[:user_id])
    else
      redirect_to login_url, notice: "You must be logged in to access admin pages"
    end
  end  
  
end


# why does the cart render when i load this view????????????