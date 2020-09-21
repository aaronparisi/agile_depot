require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal 'Thank you for your order!', mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["aarons.coding.stuff@gmail.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal 'Your Depot order has shipped!', mail.subject
    assert_equal ["dave@example.com"], mail.to
    assert_equal ["aarons.coding.stuff@gmail.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  end

end
