class Gift < ActiveRecord::Base
  EMAIL_REG_EXP = /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$/i

  attr_accessible :plan_type, :sender_email, :note, :recipient_email, :transaction_status, :transaction_date, :transaction_code, :gift_code
  validates :sender_email, :recipient_email , :presence => {:message => I18n.t('message.not_blank')}, :format => {:with => EMAIL_REG_EXP, :message => I18n.t('message.invalid_email')}
  validates_associated :billing_address
  validates_uniqueness_of :order_code

  has_one :redeem
  belongs_to :billing_address, :class_name => 'Address'
  accepts_nested_attributes_for :billing_address
  before_create :generate_gift_code, :generate_order_code

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

  protected
    def generate_gift_code
      self.gift_code = SecureRandom.hex(6) + Gift.count.to_s
    end

    def generate_order_code
      self.order_code = SecureRandom.hex(4) + Gift.count.to_s
    end
end
