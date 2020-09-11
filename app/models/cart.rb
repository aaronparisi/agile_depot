# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def add_product(product_id, dir)
    logger.debug "inside add product with dir = #{dir}"

    current_item = line_items.find_by(product_id: product_id)
    if current_item
      dir == "inc" ? current_item.quantity += 1 : current_item.quantity -= 1
    else
      price = Product.find(product_id).price
      current_item = line_items.build(product_id: product_id, product_price: price)
      # I think this is saying "self.line_items"
    end
    current_item
    # return the current item so it can be saved in the database
    # note that this current item might have the same line_item id as an entry
    # that already exists
    # ? how does 'save' work in this case?
  end

  def total_price
    self.line_items.to_a.sum {|item| item.total_price}
  end

  def empty?
    self.line_items.to_a.empty?
  end
  
  
end

# comment