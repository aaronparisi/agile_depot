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
require 'test_helper'
require 'byebug'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "order attributes must not be empty" do
    order = Order.new
    assert order.invalid?
    assert order.errors[:name].any?
    assert order.errors[:address].any?
    assert order.errors[:email].any?
    # assert order.errors[:pay_type].any?
  end

  test "pay type must be valid" do
    order = Order.new(
      name:    "Aaron Parisi",
      address: "4676 Eastern Ave N",
      email:   "parisi.aaron@gmail.com"
    )

    order.pay_type = "feces"
    assert order.invalid?
    assert_equal ["'feces' is not a valid pay_type"], order.errors[:pay_type]
    # ArgumentError: 'feces' is not a valid pay_type => um, I know, that's the point?????
    # notice that when we tested the product model,
    # we were entering numerically valid input

    order.pay_type = "Check"
    # why is pay type 0 instead of "Check"????????????
    assert order.valid?
  end
end
