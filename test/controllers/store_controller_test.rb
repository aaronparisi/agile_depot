require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    # there should be at least 4 anchors desc from: (id="side" desc from: (id="columns"))
    # these correspond to the 4 links in the sidebar
    assert_select '#main .entry', 3
    # there should be 3 entries (our 3 products in the products.yml file)
    # remember we are running tests using the database data,
    # we are using a separate set of data
    assert_select 'h3', 'Lord of the Rings, The Two Towers'
    assert_select '.price', /\$[,\d]+\.\d\d/
    # anything with class=price should match that format: '$' followed by 
    # digits and commas followed by '.' followed by 2 digits
    assert_select '#visit_count', 1
  end

end
