class GiftsController < ApplicationController
  before_filter :complete_checking, :only => [:step_1, :step_2, :step_3, :step_4]

  def step_1
    @gift = Gift.new unless @gift
  end

  def step_2
    redirect_to step_1_gifts_path unless @gift
  end

  def step_3
    if @gift.nil?
      flash[:notice] = I18n.t('message.email_missing')
      redirect_to step_1_gifts_path
    elsif @gift.plan_type.nil?
      flash[:notice] = I18n.t('message.plan_missing')
      redirect_to step_2_gifts_path(:gift_id => @gift.id)
    else
      @gift.build_billing_address unless @gift.billing_address
    end
  end

  def step_4
    if @gift.nil?
      flash[:notice] = I18n.t('message.email_missing')
      redirect_to step_1_gifts_path
    elsif @gift.plan_type.nil?
      flash[:notice] = I18n.t('message.plan_missing')
      redirect_to step_2_gifts_path(:gift_id => @gift.id)
    elsif @gift.billing_address.nil?
      flash[:notice] = I18n.t('message.billing_missing')
      redirect_to step_3_gifts_path(:gift_id => @gift.id)
    else
      # todo
      @gift.update_attribute(:total, @gift.total_price)
    end
  end



  def create_update_gift
    info = params[:gift]
    recipient_email_conf = info.delete :recipient_email_confirm
    sender_email_conf = info.delete :sender_email_confirm

    @gift = Gift.new info
    flag = true
    if recipient_email_conf != params[:gift][:recipient_email]
      @gift.errors.add('recipient_email_confirm', 'Does not match')
      @gift.attributes['recipient_email_confirm'] = params[:gift][:recipient_email_confirm]
      flag = false
    end
    if sender_email_conf != params[:gift][:sender_email]
      @gift.errors.add('sender_email_confirm', 'Does not match')
      @gift.attributes['sender_email_confirm'] = params[:gift][:sender_email_confirm]
      flag = false
    end

    if !flag
      render step_1_gifts_path
    else
      if @gift.save
        redirect_to step_2_gifts_path(:gift_id => @gift.id)
      else
        flash[:error] = @gift.errors.full_messages
        render step_1_gifts_path
      end
    end
  end

  def update_gift_plan
    @gift = Gift.find_by_id params[:gift_id]
    if params.has_key?(:gift)
      @gift.attributes = params[:gift]
      @gift.price = Order::PRICE[@gift.plan_type] if params[:gift].has_key?('plan_type')
      if @gift.save
        redirect_to step_3_gifts_path(:gift_id => @gift.id)
      else
        flash[:notice] = @gift.errors.full_messages
        render step_2_gifts_path
      end
      params[:gift_action]
    else
      flash[:notice] = I18n.t('message.plan_missing')
      render step_2_gifts_path
    end
  end

  def update_gift_billing
    info = params[:gift][:billing_address_attributes]
    @gift = Gift.find_by_id params[:gift_id]
    if @gift.billing_address.nil?
      @gift.build_billing_address(info)
    else
      @gift.billing_address.attributes = info
    end

    @gift.tax = @gift.get_tax
    if @gift.save
      redirect_to step_4_gifts_path(:gift_id => @gift.id)
    else
      render step_3_gifts_path
    end
  end


  def finish

    gift = Gift.find_by_id(params[:gift_id])
    gift.update_attribute(:transaction_status, Order::TRANSACTION_STATUS[:processing])
    @response = Payment.an_process(gift.total_price, params)
    if @response.success?
      flash[:success] = "Successfully made a purchase (authorization code: #{@response.authorization_code})"
      gift.update_attributes({:transaction_status => Order::TRANSACTION_STATUS[:completed], :transaction_date => Time.now, :transaction_code => @response.transaction_id})
      # UserMailer.order_confirm(user, order, params, @response.transaction_id).deliver
      # UserMailer.order_confirm_to_admin(user, order, params, @response.transaction_id).deliver
    else
      flash[:error] = @response.response_reason_text
      redirect_to :back
    end
  end

  protected
    def complete_checking
      @gift = Gift.find_by_id params[:gift_id]
      if @gift and (@gift.transaction_status == Order::TRANSACTION_STATUS[:completed].to_s)
        flash[:success] = I18n.t('message.gift_success')
        redirect_to step_1_gifts_path
      end
    end
end
