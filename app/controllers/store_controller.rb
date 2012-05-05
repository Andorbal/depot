class StoreController < ApplicationController
  skip_before_filter :authorize
  
  def index
    @access_count = access_count
    increment_access_count
    @products = Product.order(:title)
    @cart = current_cart
  end
end
