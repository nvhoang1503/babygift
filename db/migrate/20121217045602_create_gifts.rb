class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :recipient_email, :null => false
      t.string :sender_email, :null => false
      t.text :note
      t.integer :plan_type
      t.belongs_to :shipping_address
      t.belongs_to :billing_address

      t.timestamps
    end
  end
end
