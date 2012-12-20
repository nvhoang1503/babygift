class GiftsController < ApplicationController
  def step_1
    @gift = Gift.new
  end

  def step_2
  end

  def step_3
  end

  def step_4
  end

  def finish
  end

  def update_gift
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
