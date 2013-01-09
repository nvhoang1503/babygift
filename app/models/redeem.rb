class Redeem < ActiveRecord::Base
  attr_accessible :gift_code, :user_id, :gender, :shipping_address_id, :price, :tax, :shipping_fee, :total, :transaction_code, :transaction_date, :transaction_status

  set_table_name :gifts
  validates :gift_code, :presence => {:message => I18n.t('message.not_blank')}
  validates_associated :billing_address

  belongs_to :gift
  belongs_to :billing_address, :class_name => 'Address'
  accepts_nested_attributes_for :billing_address
end
