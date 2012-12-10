class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :baby, :null => false
      t.integer :plan_type, :null => false
      t.float :price, :default => 0
      t.float :tax, :default => 0
      t.float :shipping_fee, :default => 0
      t.float :total, :defaut => 0
      t.string :current_step
      t.belongs_to :shipping_address
      t.belongs_to :billing_address
      t.belongs_to :purchaser
      t.string :transaction_code
      t.datetime :transaction_date
      t.string :transaction_status
      t.string :gift_code

      t.timestamps
    end
  end
end
