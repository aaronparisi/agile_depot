class StoreController < ApplicationController
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
