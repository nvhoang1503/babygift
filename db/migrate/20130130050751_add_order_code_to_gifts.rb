class AddOrderCodeToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :order_code, :string
  end
end
