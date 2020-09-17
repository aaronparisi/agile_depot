require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "requires item in cart" do
    get new_order_url  # this will call set_cart, but test session is empty??
    assert_redirected_to store_index_url
    assert_equal flash[:notice], 'Your cart is empty'
  end

  test "should get new" do
    # if we just issue the get request, the cart will be empty
    # so we first have to add a line item to a cart
    # we do this in the application by clicking the add to cart button
    # which is a button_to (i.e. post request to) line_items_path
    # so we just force that here
    post line_items_path, params: { product_id: products(:lotr).id, dir: :inc}
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
