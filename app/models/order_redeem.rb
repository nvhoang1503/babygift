class Order_Redeem

  def id=(id)
    @id = id
  end

  def id
    @id
  end

  def baby_id=(baby_id)
    @baby_id = baby_id
  end

  def baby_id
    @baby_id
  end

  def plan_type=(plan_type)
    @plan_type = plan_type
  end

  def plan_type
   @plan_type
  end

  def transaction_date=(transaction_date)
    @transaction_date = transaction_date
  end

  def transaction_date
    @transaction_date
  end

  def order_type=(order_type)
    @order_type = order_type
  end

  def order_type
    @order_type
  end

  def baby
    @baby
  end

  def baby=(baby)
    @baby = baby
  end

  def shipping_address
    @shipping_address
  end

  def shipping_address=(shipping_address)
    @shipping_address = shipping_address
  end

  def billing_address
    @billing_address
  end

  def billing_address=(billing_address)
    @billing_address = billing_address
  end


  def order_code
    @order_code
  end

  def order_code=(order_code)
    @order_code = order_code
  end


  def initialize(order_redeem)
    @id = order_redeem.id
    @baby_id = order_redeem.baby_id
    @plan_type = order_redeem.plan_type
    @transaction_date = order_redeem.transaction_date
    @order_code = order_redeem.order_code
    @order_type = order_redeem.order_type
    @baby = order_redeem.baby
    @shipping_address = order_redeem.shipping_address
    @billing_address = order_redeem.billing_address
    @order_code = order_redeem.order_code

  end


  def self.order_redeem_by_user(user_id)
    transaction_status = Order::TRANSACTION_STATUS[:completed]
    redeem_status = Redeem::STATUS[:completed]
    # sql = " select id, baby_id,plan_type,transaction_date,order_code, 1 as order_type
    #         from orders
    #         where transaction_status = '#{transaction_status}'
    #         and baby_id in (
    #           select id
    #           from babies
    #           where user_id = #{user_id}
    #           )
    #         union all
    #         select id, baby_id,plan_type,transaction_date, order_code, 2
    #         from gifts
    #         where redeem_status = '#{redeem_status}'
    #         and baby_id in (
    #         select id
    #         from babies
    #         where user_id = #{user_id}
    #         )
    #         order by transaction_date
    #       "
    # orders = Order.find_by_sql(sql)
    orders = Order.find_by_id(id)
    redeems =

    order_redeem_list = []
    orders.each do |order|
      new_oder_redeem = Order_Redeem.new(order)
      order_redeem_list<<  new_oder_redeem
    end

    return order_redeem_list

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

end
