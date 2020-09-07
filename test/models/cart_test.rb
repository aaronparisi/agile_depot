# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  fixtures :products

  setup do
    @cart = carts(:one)
  end

  test "should return new line item when product is unique" do
    ret = @cart.add_product(products(:lotr).id)
    assert_nil(ret.id)
  end

  test "should return an already existing line item for duplicate product" do
    ret = @cart.add_product(products(:two).id)
    assert_not_nil(ret.id)
  end

  test "should increment quantity for duplicate product" do
    ret = @cart.add_product(products(:two).id)
    assert_equal(2, ret.quantity)
  end
end
