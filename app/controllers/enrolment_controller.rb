class EnrolmentController < ApplicationController
  def step_1
    @baby = Baby.new
  end

  def create_baby
    birthday = params[:child][:birthday]
    params[:child][:birthday] = Date.strptime(birthday, '%m/%d/%Y') if birthday.present?
    @baby = Baby.new params[:child]
    if @baby.save
      redirect_to enrolment_step_2_path(:baby_id => @baby.id)
    else
      render enrolment_step_1_path
    end
  end

  def step_2
    @order = Order.new
  end

  def create_plan
    @order = Order.new params[:plan]
    @order.price = Order::PRICE[@order.plan_type] if params[:plan] && params[:plan].has_key?('plan_type')
    # @order.transaction_status = Order::TRANSACTION_STATUS[:start]
    @order.tax = 0
    if @order.save
      redirect_to enrolment_step_3_path(:order_id => @order.id)
    else
      flash[:error] = I18n.t('content.page.enroll_2.plan_missing')
      render enrolment_step_2_path
    end
  end

  def step_3
    if user_signed_in?
      Order.where(:id => params[:order_id].to_i).update_all(:purchaser_id => current_user.id)
      return redirect_to enrolment_step_4_path(:order_id => params[:order_id])
    end
  end

  def step_4
    return redirect_to enrolment_step_3_path(:order_id => params[:order_id]) unless user_signed_in?
    @order = Order.find_by_id(params[:order_id])
    @order.build_shipping_address
    @order.build_billing_address
  end

  def update_order_shipping
    ship_to_billing = params[:plan].delete :ship_to_billing
    @order = Order.find_by_id params[:plan][:id]
    params[:plan].delete('billing_address_attributes') if ship_to_billing
    if @order.update_attributes params[:plan]
      @order.update_attribute(:billing_address_id, @order.shipping_address_id)
      redirect_to enrolment_step_5_path(:order_id => @order.id)
    else
      render enrolment_step_4_path(:order_id => @order.id)
    end
  end

  def step_5
    return redirect_to enrolment_step_3_path(:order_id => params[:order_id])  unless user_signed_in?
    @order = Order.find_by_id(params[:order_id])
  end

  def finish
    order = Order.find_by_id(params[:order_id])
    order.update_attribute(:transaction_status, Order::TRANSACTION_STATUS[:processing])
    @response = Payment.an_process(params)

    if @response.success?
      flash[:success] = "Successfully made a purchase (authorization code: #{@response.authorization_code})"
      order.update_attribute(:transaction_status, Order::TRANSACTION_STATUS[:completed])
      user = current_user
      UserMailer.enroll_email(user, @response.transaction_id).deliver
    else
      flash[:error] = @response.response_reason_text
      redirect_to :back
    end
  end
end
