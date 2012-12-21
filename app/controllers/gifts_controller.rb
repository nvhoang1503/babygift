class GiftsController < ApplicationController
  def step_1
    @gift = Gift.new
  end

  def step_2
    @gift = Gift.find_by_id params[:gift_id]
    redirect_to step_1_gifts_path unless @gift
  end

  def step_3
    @gift = Gift.find_by_id params[:gift_id]
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
  end

  def finish
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
      if @gift.update_attributes(params[:gift])
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
    if @gift.save
      redirect_to step_4_gifts_path(:gift_id => @gift.id)
    else
      render step_3_gifts_path
    end
  end
end

