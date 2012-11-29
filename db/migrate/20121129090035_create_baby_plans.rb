class CreateBabyPlans < ActiveRecord::Migration
  def change
    create_table :baby_plans do |t|
      t.references :baby, :null => false
      t.integer :type, :null => false
      t.float :price, :null => false

      t.timestamps
    end
  end
end
