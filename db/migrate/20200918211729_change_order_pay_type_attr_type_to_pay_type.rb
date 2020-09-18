class ChangeOrderPayTypeAttrTypeToPayType < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :pay_type
    add_reference :orders, :pay_type, index: true
    add_foreign_key :orders, :pay_type
  end
end
