class Order < ActiveRecord::Base
  TAX = {
    :rate => 0.05,
    :state => ['CA']
  }
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
  TRANSACTION_STATUS = {
    :start => 0,
    :processing => 1,
    :completed => 2
  }
  STEPS = {
    :child_register => 0,
    :plan_select => 1,
    :sign_in => 2,
    :addresses_input => 3,
    :payment => 4
  }

  attr_accessible :baby_id, :plan_type, :price, :transaction_status, :transaction_date, :transaction_code, :shipping_address_attributes, :billing_address_attributes
  validates_presence_of :baby, :plan_type, :price

  belongs_to :baby
  belongs_to :shipping_address,
    :class_name => 'Address', :foreign_key => :shipping_address_id
  belongs_to :billing_address,
    :class_name => 'Address', :foreign_key => :billing_address_id
  accepts_nested_attributes_for :shipping_address, :billing_address, :baby
  belongs_to :purchaser,
    :class_name => 'User', :foreign_key => :purchaser_id

  before_create :update_transaction_status

  def total_order
    self.price + self.get_tax + self.shipping_fee  #temp
  end

  def get_tax
    if TAX[:state].include? self.billing_address.state
      return self.price * TAX[:rate]
    else
      return 0
    end
  end

  protected
    def update_transaction_status
      self.transaction_status = TRANSACTION_STATUS[:start]
    end
end
