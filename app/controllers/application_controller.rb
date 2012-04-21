class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_cart
    Cart.find session[:cart_id]
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def access_count
    session[:counter] || 1
  end

  def increment_access_count
    session[:counter] = access_count + 1
  end

  def reset_access_count
    session[:counter] = nil
  end
end
