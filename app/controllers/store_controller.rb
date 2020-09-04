class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @page_title = "Your Pragmatic Catalog"
    
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @visit_count = session[:counter]
  end
end
