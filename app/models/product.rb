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
class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :title, length: {minimum: 10}
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }

  has_many :line_items
  has_many :carts, through: :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_ref_by_line_items

  private

  def ensure_not_ref_by_line_items
    unless line_items.empty?
      # this is self.line_items, not the entire table
      errors.add(:base, 'Line Items present')
      throw :abort
      # I think this will yield the "rails aborted" line in the terminal?
    end
  end
  
end

# ? why can I create new products in the rails console with negative prices?
# because the model validations are not run until you try to save the
# data in the databse
# ? why does price: 1 result in price: 0.1e1?
# 0.1 x 10^1 = 1
# ? why doesn't the image_url validation fail when I fuck w the regex??
# because you defined the test INSIDE the new_product() method
# so the tests didn't even run