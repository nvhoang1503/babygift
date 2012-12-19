class EnrolmentController < ApplicationController
  before_filter :get_baby_order

  def step_1
    @baby = Baby.new unless @baby
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
      render step_1_enrolments_path
    end
  end

  def step_2
    @order = Order.new unless @order
    unless @baby
      flash[:warning] = 'Register your child first!'
      redirect_to step_1_enrolments_path
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
      flash[:error] = I18n.t('content.page.enroll_2.plan_missing')
      render step_2_enrolments_path
    end
  end

  def step_3
    unless @order
      if @baby
        flash[:notice] = I18n.t('content.page.enroll_2.plan_missing')
        return redirect_to step_2_enrolments_path(:baby_id => @baby.id)
      else
        flash[:notice] = 'Register your child first!'
        return redirect_to step_1_enrolments_path
      end
    end

    if user_signed_in?
      Order.where(:id => params[:order_id].to_i).update_all(:purchaser_id => current_user.id)
      return redirect_to step_4_enrolments_path(:order_id => params[:order_id])
    end
    @submit_from = RegistrationsController::ENROLMENT_RECEIVE
  end

  def step_4
    return redirect_to step_1_enrolments_path unless @baby
    return redirect_to step_2_enrolments_path(:baby_id => @baby.id) unless @order
    return redirect_to step_3_enrolments_path(:order_id => @order.id) unless user_signed_in?
    @order.build_shipping_address unless @order.shipping_address
    @order.build_billing_address unless @order.billing_address
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
      render step_4_enrolments_path(:order_id => @order.id)
    end
  end

  def step_5
    return redirect_to step_1_enrolments_path unless @baby
    return redirect_to step_2_enrolments_path(:baby_id => @baby.id) unless @order
    return redirect_to step_3_enrolments_path(:order_id => @order.id) unless user_signed_in?
    if !@order.shipping_address or !@order.billing_address
      flash[:warning] = 'Please update your addresses!'
      return redirect_to step_4_enrolments_path(:order_id => params[:order_id])
    end
  end

  def finish
    order = Order.find_by_id(params[:order_id])
    order.update_attribute(:transaction_status, Order::TRANSACTION_STATUS[:processing])
    @response = Payment.an_process(params)
    if @response.success?
      flash[:success] = "Successfully made a purchase (authorization code: #{@response.authorization_code})"
      order.update_attributes({:transaction_status => Order::TRANSACTION_STATUS[:completed], :transaction_date => Time.now})
      user = current_user
      UserMailer.order_confirm(user, order, params, @response.transaction_id).deliver
      UserMailer.order_confirm_to_admin(user, order, params, @response.transaction_id).deliver
    else
      flash[:error] = @response.response_reason_text
      redirect_to :back
    end
  end

  protected
    def get_baby_order
      @order = Order.find_by_id params[:order_id]
      if @order
        @baby = @order.baby
      else
        @baby = Baby.find_by_id params[:baby_id]
      end
      @baby.birthday = @baby.birthday.strftime('%m/%d/%Y') if @baby and @baby.birthday
    end
end
