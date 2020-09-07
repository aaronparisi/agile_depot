class CombineItemsInCart < ActiveRecord::Migration[5.2]
  def up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      # -> grab the line items from the cart (can contain multiple entries
      # with quantity of 1 and matching product id)
      # ... this returns an array of hashes => [{product_id: 1, cart_id: 1, quantity: 1}, {}, ...]
      # -> group them by product_id
      # ? doesn't this remove any duplicates???
      # -> I think maybe this is more like the following SQL query:
      # select product_id, sum(quantity)
      # from line_items
      # where cart_id=...
      # group by product_id;
      # "sum the quantities for the rows w matching product_id's"
      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete_all

          new = cart.line_items.build(product_id: product_id)
          # why don't we pass in the quantity here? why let it default to 1 first?
          new.quantity = quantity
          new.save!
          # this just shoves this line item, which will have the correct 
          # cart_id (cart.line_items.build) into the line_items table
        end
      end
    end
  end

  # def down
  #   Cart.all.each do |cart|    
  #     cart.line_items.each do |item|
  #       if item.quantity > 1
  #         quant = item.quantity
  #         id = item.product_id
  #         item.delete  # can I just do this or do I have to go through the cart.line_items again?
  #         quant.times do 
  #           new = cart.line_items.build(product_id: id)  # defaults to quantity of 1
  #           new.save!
  #         end
  #       end
  #     end
  #   end
  # end

  def down
    LineItem.where("quantity > 1").each do |item|
      item.quantity.times do
        LineItem.create(
          product_id: item.product_id,
          cart_id: item.cart_id,
          quantity: 1
        )
      end

      item.destroy
    end
  end
  
  
end
