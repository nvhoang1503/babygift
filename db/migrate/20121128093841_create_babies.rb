class CreateBabies < ActiveRecord::Migration
  def change
    create_table :babies do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.date :birthday
      t.integer :gender
      t.integer :caretaker #user_id

      t.timestamps
    end
  end
end
