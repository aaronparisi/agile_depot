require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  fixtures :products

  test "buying a product" do
    start_order_count = Order.count
    lotr_book = products(:lotr)

    get "/" # user goes to main store indes
    assert_response :success
    assert_select '.title', "Your Pragmatic Catalog"

    post '/line_items', params: { product_id: lotr_book.id }, xhr: true
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.length
    assert_equal lotr_book, cart.line_items.first.product

    get '/orders/new', xhr: true
    assert_response :success
    # assert_select 'legend', 'Please Enter Your Details'
    # why does additional text get included in the return result for legend??
    assert_template :partial => '_order'

    perform_enqueued_jobs do
      post "/orders", params: {
        order: {
          name:        "Dave Thomas",
          address:     "123 4th St",
          email:       "dave@example.com",
          pay_type_id: "1"
        }
      }
    end

    follow_redirect!

    assert_response :success
    assert_select 'title', "Your Pragmatic Catalog"
    cart = Cart.find(session[:cart_id])
    assert_true cart.line_items.empty?

    assert_equal start_order_count + 1, Order.count
    order = Order.last

    assert_equal "Dave Thomas", order.name
    assert_equal "123 4th St", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "1", order.pay_type_id

    assert_equal 1, order.line_items.size
    line_item = order.line_items.first
    assert_equal lotr_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Aaron Parisi <aarons.coding.stuff@gmail.com', mail[:from].value
    assert_equal 'Thank you for your order!', mail.subject
  end
end
