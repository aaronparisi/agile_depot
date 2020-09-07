class MergeProductPricesWithExistingLineItems < ActiveRecord::Migration[5.2]
  def up
    LineItem.all.each do |item|
      item.product_price = item.product.price
    end
  end

  def down
    LineItem.all.each do |item|
      item.product_price = nil
    end
  end
  
end
