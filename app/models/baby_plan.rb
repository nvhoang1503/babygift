class BabyPlan < ActiveRecord::Base
  attr_accessible :baby, :type, :price
  validates_presence_of :type, :price

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
end
