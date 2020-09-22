class AdminController < ApplicationController
  def index
    @order_count = Order.count
    @unshipped = Order.where(ship_date: nil).length
    sesh_id = session[:user_id]
    if sesh_id
      @adminUser = User.find(session[:user_id])
    else
      redirect_to new_session_path
    end
  end
  
end
