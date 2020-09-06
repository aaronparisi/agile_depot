require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      # post line_items_url, params: { line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id } }
      post line_items_url, params: {product_id: products(:lotr).id}
      # i.e. the line_items controller's create method should create a new line item
      # given only the id of the product
    end

    assert_equal session[:visit_count], 0

    follow_redirect!

    # assert_redirected_to line_item_url(LineItem.last)
    assert_select 'h2', 'Your Pragmatic Cart'
    # assert_select 'li', 'Lord of the Rings, The Two Towers'
    assert_select '#cart_line_items li', "1 \u00D7 Lord of the Rings, The Two Towers"

    # here we are saying "ok go ahead and actually do the redirect,
    # as opposed to just asserting the redirect code??"
    # and then check to make sure the page rendered has the expected content
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id } }
    assert_redirected_to line_item_url(@line_item)
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to line_items_url
  end
end
