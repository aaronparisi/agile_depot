# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  address    :text
#  email      :string
#  name       :string
#  pay_type   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Order < ApplicationRecord
  enum pay_type: {
    "Check":          0,
    "Credit Card":    1,
    "Purchase Order": 2
  }
  # "the pay_type column in the orders table is of type integer;
  # this associates those integers with the given strings"

  # ? how come we don't have any relations, like has_many :line_items ????
end
