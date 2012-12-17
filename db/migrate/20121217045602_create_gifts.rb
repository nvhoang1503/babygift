class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :recipient_email
      t.string :given_email
      t.text :note_gift
      t.integer :gitf_type

      t.timestamps
    end
  end
end
