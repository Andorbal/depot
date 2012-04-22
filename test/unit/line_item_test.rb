require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test "product_title returns product title if set" do
    item = LineItem.new product: products(:ruby)
    assert_equal item.product_title,
                 products(:ruby).title
  end

  test "product_title returns No Name if product is null" do
    item = LineItem.new
    assert_equal item.product_title, "No Name"
  end
end
