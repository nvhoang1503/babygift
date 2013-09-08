class EnrolmentController < ApplicationController
  before_filter :get_baby_order

  def step_1
    @baby = Baby.new unless @baby
    @baby.birthday = @baby.birthday.strftime('%m/%d/%Y') if @baby.birthday
  end

  def enroll_baby
    birthday = params[:child][:birthday]
    params[:child][:birthday] = Date.strptime(birthday, '%m/%d/%Y') if birthday.present?
    if @baby
      @baby.attributes = params[:child]
    else
      @baby = Baby.new params[:child]
    end
    if @baby.save
      return redirect_to step_2_enrolments_path(:baby_id => @baby.id) unless @order
      return redirect_to step_2_enrolments_path(:order_id => @order.id)
    else
      @baby[:birthday] = @baby[:birthday].strftime("%m/%d/%Y") if @baby[:birthday]
      render :action => :step_1
    end
  end

  def step_2
    @order = Order.new unless @order
    unless @baby
      # flash[:error] = 'Register your child first!'
      redirect_to step_1_enrolments_path(:submit => false)
    end
  end

  def enroll_plan
    if @order
      @order.attributes = params[:plan]
      @order.price = Order::PRICE[@order.plan_type] if params[:plan] && params[:plan].has_key?('plan_type')
      @order.baby = @baby
    else
      @order = Order.new params[:plan]
      @order.price = Order::PRICE[@order.plan_type] if params[:plan] && params[:plan].has_key?('plan_type')
      @order.tax = 0
    end
    if @order.save
      redirect_to step_3_enrolments_path(:order_id => @order.id)
    else
      # flash[:error] = @order.errors.full_message
      render :action => :step_2
    end
  end

  def step_3
    unless @order
      if @baby
        # flash[:error] = I18n.t('content.page.enroll_2.plan_missing')
        return redirect_to step_2_enrolments_path(:baby_id => @baby.id , :submit => false)
      else
        # flash[:error] = 'Register your child first!'
        return redirect_to step_1_enrolments_path(:submit => false)
      end
    end

    if user_signed_in?
      return redirect_to step_4_enrolments_path(:order_id => params[:order_id])
    end
    @submit_from = RegistrationsController::ENROLMENT_RECEIVE
  end

  def step_4
    return redirect_to step_1_enrolments_path(:submit => false) unless @baby
    return redirect_to step_2_enrolments_path(:baby_id => @baby.id, :submit => false) unless @order
    return redirect_to step_3_enrolments_path(:order_id => @order.id, :submit => false) unless user_signed_in?
    @order.update_attribute(:purchaser_id, current_user.id)
    @order.build_shipping_address unless @order.shipping_address
    @order.build_billing_address unless @order.billing_address
    # update parent_id for current baby
    @baby.update_attribute(:user_id,current_user.id)
  end

  def update_order_shipping
    ship_to_billing = params[:plan].delete :ship_to_billing
    @order = Order.find_by_id params[:plan][:id]
    if SharedMethods::Parser.Boolean(ship_to_billing)
      params[:plan].delete('billing_address_attributes')
    else
      params[:plan][:billing_address_attributes].delete('id')
    end

    if @order.update_attributes params[:plan]
      @order.update_attribute(:billing_address_id, @order.shipping_address_id) if SharedMethods::Parser.Boolean(ship_to_billing)
      redirect_to step_5_enrolments_path(:order_id => @order.id)
    else
      render :action => :step_4
    end
  end

  def step_5
    return redirect_to step_1_enrolments_path(:submit => false) unless @baby
    return redirect_to step_2_enrolments_path(:baby_id => @baby.id,:submit => false) unless @order
    return redirect_to step_3_enrolments_path(:order_id => @order.id) unless user_signed_in?
    if !@order.shipping_address or !@order.billing_address
      # flash[:error] = 'Please update your addresses!'
      return redirect_to step_4_enrolments_path(:order_id => params[:order_id] ,:submit => false)
    end
  end

  def finish
    @order = Order.find_by_id(params[:order_id])
    @order.update_attribute(:transaction_status, Order::TRANSACTION_STATUS[:processing])
    params[:billing_address_id] = @order.billing_address_id
    params[:shipping_address_id] = @order.shipping_address_id
    params[:order_code] = @order.order_code
    params[:description] = Order::TYPE_NAME[@order.plan_type]
    params[:cycle]=  Order::TYPE_CYCLE[@order.plan_type]
    

    transaction_id = nil
    subscription_id = "subscription_id"
    @order.update_attribute(:is_active_subscription, true)
    flash[:success] = "Successfully made a purchase"
    @order.update_attributes({:transaction_status => Order::TRANSACTION_STATUS[:completed], :transaction_date => Time.now, :transaction_code => transaction_id, :subscription_id => subscription_id})
    user = current_user
    UserMailer.order_confirm(user, @order, params, @order.order_code).deliver
    UserMailer.order_confirm_to_admin(user, @order, params, @order.order_code).deliver

    # response = Payment.an_create_recurring(@order.total_order, params)
    # if response.success?
    #   transaction_id = nil
    #   subscription_id = response.subscription_id
    #   @order.update_attribute(:is_active_subscription, true)
    # else
    #   error = Payment.get_recurring_error_messages(response)
    # end

    # if response.success?
    #   flash[:success] = "Successfully made a purchase"
    #   @order.update_attributes({:transaction_status => Order::TRANSACTION_STATUS[:completed], :transaction_date => Time.now, :transaction_code => transaction_id, :subscription_id => subscription_id})
    #   user = current_user
    #   UserMailer.order_confirm(user, @order, params, @order.order_code).deliver
    #   UserMailer.order_confirm_to_admin(user, @order, params, @order.order_code).deliver
    # else
    #   flash[:error] = error
    #   redirect_to :back
    # end
  end

  protected
    def get_baby_order
      @order = Order.find_by_id params[:order_id]
      if @order
        @baby = @order.baby
      else
        @baby = Baby.find_by_id params[:baby_id]
      end
      # @baby.birthday = @baby.birthday.strftime('%m/%d/%Y') if @baby and @baby.birthday
    end
end
