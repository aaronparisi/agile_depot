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
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG, or PNG image.'
  }

end

# ? why can I create new products in the rails console with negative prices?
# because the model validations are not run until you try to save the
# data in the databse
# ? why does price: 1 result in price: 0.1e1?
# 0.1 x 10^1 = 1
# ? why doesn't the image_url validation fail when I fuck w the regex??
# because you defined the test INSIDE the new_product() method
# so the tests didn't even run