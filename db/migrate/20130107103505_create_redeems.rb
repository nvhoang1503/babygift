class CreateRedeems < ActiveRecord::Migration
  def change
    create_table :redeems do |t|
      t.string :gift_code, :null => false
      t.integer :user_id
      t.integer :gift_id
      t.integer :gender
      t.belongs_to :shipping_address
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
