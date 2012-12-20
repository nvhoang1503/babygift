class GiftsController < ApplicationController
  def step_1
    @gift = Gift.new
  end

  def step_2
    @gift = Gift.find_by_id params[:gift_id]
  end

  def step_3
  end

  def step_4
  end

  def finish
  end

  def update_gift
    if params.has_key? :gift_id
      @gift = Gift.find_by_id params[:gift_id]

      if params.has_key?(:gift)
        if @gift.update_attributes(params[:gift])
          redirect_to step_3_gifts_path(:gift_id => @gift.id)
        else
          flash[:notice] = @gift.errors.full_messages
          render step_2_gifts_path
        end
      else
        flash[:notice] = I18n.t('content.page.enroll_2.plan_missing')
        render step_2_gifts_path
      end
    else
      create_gift(params)
    end
  end

  def create_gift(params)
    info = params[:gift]
    info.delete :recipient_email_confirm
    info.delete :sender_email_confirm
    @gift = Gift.new info
    flag = true
    if params[:gift][:recipient_email_confirm] != params[:gift][:recipient_email]
      @gift.errors.add('recipient_email_confirm', 'Does not match')
      @gift.attributes['recipient_email_confirm'] = params[:gift][:recipient_email_confirm]
      flag = false
    end
    if params[:gift][:sender_email_confirm] != params[:gift][:sender_email]
      @gift.errors.add('sender_email_confirm', 'Does not match')
      @gift.attributes['sender_email_confirm'] = params[:gift][:sender_email_confirm]
      flag = false
    end

    if !flag
      render step_1_gifts_path
    else
      if @gift.save
        redirect_to step_2_gifts_path
      else
        flash[:error] = @gift.errors.full_messages
        render step_1_gifts_path
      end
    end

  end

end

