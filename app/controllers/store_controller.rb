class StoreController < ApplicationController
  def index
    @access_count = access_count
    increment_access_count
    @products = Product.order(:title)
  end
end
