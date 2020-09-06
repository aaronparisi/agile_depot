class StoreController < ApplicationController
  include CurrentCart #paste the module code in this class
  before_action :set_cart, only: :index # give index access to @cart var  
  def index
    @products = Product.order(:title)
    @page_title = "Your Pragmatic Catalog"
    
    if session[:visit_count].nil?
      session[:visit_count] = 1
    else
      session[:visit_count] += 1
    end
    @visit_count = session[:visit_count]
  end
end
