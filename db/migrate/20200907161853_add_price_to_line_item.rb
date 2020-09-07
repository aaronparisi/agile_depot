class AddPriceToLineItem < ActiveRecord::Migration[5.2]
  def change
    add_column :line_items, :product_price, :decimal, precision: 8, scale: 2
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
