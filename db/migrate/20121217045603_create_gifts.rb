class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.belongs_to :shipping_address
      t.belongs_to :billing_address
      t.string :recipient_email, :null => false
      t.string :sender_email, :null => false
      t.text :note
      t.integer :plan_type

      t.integer :baby_id
      t.datetime :redeem_date
      t.string :redeem_status



      t.float :price, :default => 0
      t.float :tax, :default => 0
      t.float :shipping_fee, :default => 0
      t.float :total, :defaut => 0
      t.string :transaction_code
      t.datetime :transaction_date
      t.string :transaction_status
      t.string :gift_code

      t.timestamps
    end
  end
end
