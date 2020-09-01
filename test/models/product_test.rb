# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :text
#  image_url   :string
#  price       :decimal(8, 2)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(
      title:       "My Book Title",
      description: "yyy",
      image_url:   "zzz.jpg"
    )
    product.price = -1

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
      title:       "My Book Title",
      description: "yyy",
      price:       1,
      image_url:   image_url
    )
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    notok = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |url|
      assert new_product(url).valid?, "#{url} should be valid"
    end
    
    notok.each do |url|
      assert new_product(url).invalid?, "#{url} shouldn't be valid"
    end      
  end

  test "product is not valid without a unique title" do
    # notice that the info in test/fixtures/products.yml 
    # is in the db as of the start of this (and all) tests
    title_thief = Product.new(
      title:       products(:lotr).title,
      # steals the title => product should be invalid
      description: "yyy",
      price:       1,
      image_url:   "2towers.jpg"
    )

    assert title_thief.invalid?, "#{title_thief.title} should be a repeat"
    assert_equal ["has already been taken"], title_thief.errors[:title]
    # ensure we actually get the error we expect on the title attribute
  end

  test "title is at least 10 characters" do
    product = Product.new(
      description: "yyy",
      price: 1,
      image_url: "fake.jpg"
    )

    product.title = "too short"
    assert product.invalid?, "#{product.title} should be too short" 
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]

    product.title = "0123456789"
    assert product.valid?, "#{product.title} should be exactly 10 characters"

    product.title = "this is wayyyyyyyyyy longer than 10 characters"
    assert product.valid?, "#{product.title} should be longer than 10 chars"
  end
end
