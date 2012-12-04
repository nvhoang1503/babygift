class CreateBabyPlans < ActiveRecord::Migration
  def change
    create_table :baby_plans do |t|
      t.references :baby, :null => false
      t.integer :plan_type, :null => false
      t.float :price, :null => false
      t.belongs_to :shipping
      t.belongs_to :billing

      t.timestamps
    end
  end
end
