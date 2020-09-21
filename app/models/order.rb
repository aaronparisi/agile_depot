# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  address     :text
#  email       :string
#  name        :string
#  ship_date   :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pay_type_id :integer
#
# Indexes
#
#  index_orders_on_pay_type_id  (pay_type_id)
#
class Order < ApplicationRecord

  has_many :line_items, dependent: :destroy
  belongs_to :pay_type
  # "the pay_type column in the orders table is of type integer;
  # this associates those integers with the given strings"

  validates :name, :address, :email, presence: true
  validates :pay_type_id, inclusion: PayType.all.pluck(:id)

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil  # the cart is destroyed upon order creation
      # item.order_id = self.id
      self.line_items << item  # this sets the line item's order_id????
    end
  end
  
end
