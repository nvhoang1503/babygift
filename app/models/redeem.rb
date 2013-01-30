class Redeem < Gift

  STATUS = {
    :start => 1,
    :completed => 2
  }

  attr_accessible :gift_code, :user_id, :gender, :shipping_address_id, :price, :tax, :shipping_fee, :total, :transaction_code, :transaction_date, :transaction_status

  # without DEPRECATION WARNING we should use self.table_name = 'gifts' instead
  # set_table_name :gifts
  self.table_name = 'gifts'
  validates :gift_code, :presence => {:message => I18n.t('message.not_blank')}
  validates_associated :shipping_address
  belongs_to :baby
  belongs_to :gift
  belongs_to :shipping_address, :class_name => 'Address'
  belongs_to :billing_address, :class_name => 'Address'
  accepts_nested_attributes_for :shipping_address
end
