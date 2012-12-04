class BabyPlan < ActiveRecord::Base
  TYPE = {
    '1_mon' => 1,
    '3_mon' => 2,
    '6_mon' => 3,
    '12_mon' => 4
  }
  PRICE = {
    TYPE['1_mon'] => 34.99,
    TYPE['3_mon'] => 99.99,
    TYPE['6_mon'] => 199.99,
    TYPE['12_mon'] => 379.99
  }

  attr_accessible :baby, :plan_type, :price, :shipping_address_attributes, :billing_address_attributes
  validates_presence_of :baby, :plan_type, :price

  belongs_to :baby
  belongs_to :shipping_address,
    :class_name => 'Address', :foreign_key => :shipping_id
  belongs_to :billing_address,
    :class_name => 'Address', :foreign_key => :billing_id
  accepts_nested_attributes_for :shipping_address, :billing_address, :baby
end
