class Gift < ActiveRecord::Base
  EMAIL_REG_EXP = /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$/i

  attr_accessible :plan_type, :sender_email, :note, :recipient_email, :transaction_status, :transaction_date, :transaction_code
  validates :sender_email, :recipient_email , :presence => {:message => I18n.t('message.not_blank')}, :format => {:with => EMAIL_REG_EXP, :message => I18n.t('message.invalid_email')}
  validates_associated :billing_address

  belongs_to :shipping_address, :class_name => 'Address'
  belongs_to :billing_address, :class_name => 'Address'
  accepts_nested_attributes_for :billing_address

  def total_price
    self.price + self.get_tax + self.shipping_fee  #temp
  end

  def get_tax
    if Order::TAX[:state].include? self.billing_address.state
      return self.price * Order::TAX[:rate]
    else
      return 0
    end
  end
end
