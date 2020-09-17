# == Schema Information
#
# Table name: line_items
#
#  id            :integer          not null, primary key
#  product_price :decimal(8, 2)
#  quantity      :integer          default(1)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cart_id       :integer
#  order_id      :integer
#  product_id    :integer
#
# Indexes
#
#  index_line_items_on_cart_id     (cart_id)
#  index_line_items_on_order_id    (order_id)
#  index_line_items_on_product_id  (product_id)
#
require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
