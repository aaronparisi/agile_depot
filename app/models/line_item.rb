# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  quantity   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :integer
#  product_id :integer
#
# Indexes
#
#  index_line_items_on_cart_id     (cart_id)
#  index_line_items_on_product_id  (product_id)
#
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    self.quantity * self.product.price
  end
  
end
