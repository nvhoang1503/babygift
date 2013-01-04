class GiftsController < ApplicationController
  before_filter :complete_checking

  def step_1
    @gift = Gift.new unless @gift
  end

  def step_2
    unless @gift
      # flash[:notice] = I18n.t('message.email_missing')
      redirect_to step_1_gifts_path(:submit => false)
    end
  end

  def step_3
    if @gift.nil?
      # flash[:notice] = I18n.t('message.email_missing')
      redirect_to step_1_gifts_path(:submit => false)
    elsif @gift.plan_type.nil?
      # flash[:notice] = I18n.t('message.plan_missing')
      redirect_to step_2_gifts_path(:gift_id => @gift.id,:submit => false)
    else
      @gift.build_billing_address unless @gift.billing_address
    end
  end

  def step_4
    if @gift.nil?
      # flash[:notice] = I18n.t('message.email_missing')
      redirect_to step_1_gifts_path(:submit => false)
    elsif @gift.plan_type.nil?
      # flash[:notice] = I18n.t('message.plan_missing')
      redirect_to step_2_gifts_path(:gift_id => @gift.id,:submit => false )
    elsif @gift.billing_address.nil?
      # flash[:notice] = I18n.t('message.billing_missing')
      redirect_to step_3_gifts_path(:gift_id => @gift.id,:submit => false)
    else
      # todo
      @gift.update_attribute(:total, @gift.total_price)
    end
  end

  def create_update_gift
    info = params[:gift]
    recipient_email_conf = info.delete :recipient_email_confirm
    sender_email_conf = info.delete :sender_email_confirm

    if @gift
      @gift.attributes = info
    else
      @gift = Gift.new info
    end
    flag = true
    if recipient_email_conf != params[:gift][:recipient_email]
      @gift.errors.add('recipient_email_confirm', I18n.t('message.not_match'))
      @gift.attributes['recipient_email_confirm'] = params[:gift][:recipient_email_confirm]
      flag = false
    end
    if sender_email_conf != params[:gift][:sender_email]
      @gift.errors.add('sender_email_confirm', I18n.t('message.not_match'))
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
    if params.has_key?(:gift)
      @gift.attributes = params[:gift]
      @gift.price = Order::PRICE[@gift.plan_type] if params[:gift].has_key?('plan_type')
      if @gift.save
        redirect_to step_3_gifts_path(:gift_id => @gift.id)
      else
        flash[:error] = @gift.errors.full_messages
        render step_2_gifts_path
      end
      params[:gift_action]
    else
      # flash[:error] = I18n.t('message.plan_missing')
      render step_2_gifts_path(:submit => false)
    end
  end

  def update_gift_billing
    info = params[:gift][:billing_address_attributes]
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
    @gift.update_attribute(:transaction_status, Order::TRANSACTION_STATUS[:processing])
    params[:billing_address_id] = @gift.billing_address_id
    params[:shipping_address_id] = @gift.shipping_address_id
    @response = Payment.an_process(@gift.total_price, params)
    if @response.success?
      flash[:success] = "Successfully made a purchase (authorization code: #{@response.authorization_code})"
      @gift.update_attributes({:transaction_status => Order::TRANSACTION_STATUS[:completed], :transaction_date => Time.now, :transaction_code => @response.transaction_id})

      UserMailer.gift_confirm_to_admin(@gift, params, @response.transaction_id).deliver
      UserMailer.gift_confirm_to_sender(@gift, params, @response.transaction_id).deliver
      UserMailer.gift_confirm_to_recipient(@gift, params, @response.transaction_id).deliver

    else
      flash[:error] = Payment.get_error_messages(@response)
      redirect_to :back
    end
  end

  protected
    def complete_checking
      @gift = Gift.find_by_id params[:gift_id]
      if @gift and ( (@gift.transaction_status == Order::TRANSACTION_STATUS[:completed].to_s) or @gift.transaction_code.present? )
        flash[:success] = I18n.t('message.gift_success')
        redirect_to step_1_gifts_path
      end
    end
end
