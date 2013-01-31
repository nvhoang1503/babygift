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
  TYPE_DURATION = {
    TYPE['1_mon'] => '1 month',
    TYPE['3_mon'] => '3 months',
    TYPE['6_mon'] => '6 months',
    TYPE['12_mon'] =>'12 months'
  }
  TYPE_DUR = {
    TYPE['1_mon'] => '1-month',
    TYPE['3_mon'] => '3-month',
    TYPE['6_mon'] => '6-month',
    TYPE['12_mon'] =>'12-month'
  }
  TYPE_NAME = {
    TYPE['1_mon'] => '1-Month Kit',
    TYPE['3_mon'] => '3-Months Kit',
    TYPE['6_mon'] => '6-Months Kit',
    TYPE['12_mon'] =>'12-Months Kit'
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

  attr_accessible :baby_id, :plan_type, :price, :transaction_status, :transaction_date, :subscription_id, :transaction_code, :shipping_address_attributes, :billing_address_attributes, :baby_attributes
  validates_presence_of :baby, :plan_type, :price
  validates_uniqueness_of :order_code, :message => I18n.t('message.unq_order_code')

  belongs_to :baby
  belongs_to :purchaser,
    :class_name => 'User', :foreign_key => :purchaser_id
  belongs_to :shipping_address,
    :class_name => 'Address', :foreign_key => :shipping_address_id
  belongs_to :billing_address,
    :class_name => 'Address', :foreign_key => :billing_address_id
  accepts_nested_attributes_for :shipping_address, :billing_address, :baby

  before_create :update_transaction_status, :generate_order_code

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

  def plan_detail_with_price
    "#{TYPE_DUR[self.plan_type]} $#{PRICE[self.plan_type]}"
  end

  def is_cancelable?
    return false if self.plan_type == TYPE['1_mon'] or self.subscription_id.blank?

    transaction = AuthorizeNet::ARB::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], :gateway => :sandbox)
    response = transaction.get_status(self.subscription_id)
    if response.subscription_status.nil? or response.subscription_status == AuthorizeNet::ARB::Subscription::Status::CANCELED
      result = false
    else
      result = true
    end
    return result
  end

  def self.order_redeem_by_user(user_id)
    transaction_status = Order::TRANSACTION_STATUS[:completed]
    redeem_status = Redeem::STATUS[:completed]
    sql = " select id, baby_id,plan_type,transaction_date,order_code, shipping_address_id, 1 as order_type
            from orders
            where transaction_status = '#{transaction_status}'
            and baby_id in (
              select id
              from babies
              where user_id = #{user_id}
              )
            union all
            select id, baby_id,plan_type,transaction_date, order_code,shipping_address_id, 2
            from gifts
            where redeem_status = '#{redeem_status}'
            and baby_id in (
            select id
            from babies
            where user_id = #{user_id}
            )
            order by transaction_date
          "
    orders = Order.find_by_sql(sql)
    return orders
  end

  def self.order_redeem_detail(id,type)
    obj = nil
    if type == 1
      obj = Order.find_by_id(id)
    else
      obj = Redeem.find_by_id(id)
    end
    return obj
  end

  def plan_detail_with_price
    "#{TYPE_DUR[self.plan_type]} $#{PRICE[self.plan_type]}"
  end

  protected
    def update_transaction_status
      self.transaction_status = TRANSACTION_STATUS[:start]
    end

    def generate_order_code
      self.order_code = SecureRandom.hex(4) + Order.count.to_s
    end
end
