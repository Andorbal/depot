class Cart < ActiveRecord::Base
  attr_accessible :cart_id, :product_id
  has_many :line_items, dependent: :destroy
end
