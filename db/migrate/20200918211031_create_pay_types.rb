class CreatePayTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :pay_types do |t|
      t.string :pay_type

      t.timestamps
    end
  end
end
