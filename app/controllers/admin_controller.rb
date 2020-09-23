class AdminController < ApplicationController

  def index
    @order_count = Order.count
    @unshipped = Order.where(ship_date: nil).length
    @adminUser = User.find(session[:user_id])
  end  
  
end


# why does the cart render when i load this view????????????