require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do 
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new title: "My Book Title",
                          description: "yyy",
                          image_url: "zzz.jpg"
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 product.errors[:price].join('; ')

    product.price = 0.01
    assert product.valid?                 
  end

  def new_product(opts = {})
    Product.new({title: "My Book Title",
                description: "yyy",
                price: 1,
                image_url: "foo.gif"}.merge(opts))
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png 
             FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(image_url: name).valid?,
             "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(image_url: name).invalid?,
             "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = new_product title: products(:ruby).title
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
                 product.errors[:title].join('; ')
  end

  test "product name must be ten characters or greater" do
    product = new_product(title: "abcdefghi")
    assert product.invalid?
    assert product.errors[:title].any?

    product.title = "abcdefghij"
    assert product.valid?
  end
end