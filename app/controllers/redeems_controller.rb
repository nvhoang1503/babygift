class RedeemsController < ApplicationController
  before_filter :complete_checking

  def step_1
    @redeem = Redeem.new unless @redeem
  end

  def create_update
    info = params[:redeem]
    gift_code = params[:redeem][:gift_code]
    if @redeem
      @redeem.attributes = info
    else
      @redeem = Redeem.new info
    end
    flag = true
    if gift_code == ""
      @redeem.errors.add('gift_code', I18n.t('message.not_blank'))
      flag = false
    else
      if !Gift.exists?(:gift_code => gift_code)
        @redeem.errors.add('gift_code', I18n.t('message.gift_code_incorrect'))
        flag = false
      end
    end
    if !flag
      render step_1_redeems_path
    else
      gift = Gift.find_by_gift_code(gift_code)
      @redeem.gift_id = gift.id
      if @redeem.save
          redirect_to step_2_redeems_path(:redeem_id => @redeem.id)
      else
        flash[:error] = @redeem.errors.full_messages
        render step_1_redeems_path
      end
    end

  end

  def step_2
    @submit_from = RegistrationsController::REDEEM_RECEIVE
    if user_signed_in?
      return redirect_to step_3b_redeems_path(:redeem_id => params[:redeem_id])
    end

  end

  def update_redeem_plan

  end

  def step_3
    @baby = Baby.new
  end

  def step_3b
    if current_user.babies.count == 0
      return redirect_to step_3_redeems_path(:redeem_id => params[:redeem_id])
    end
  end

  def create_update_child
    birthday = params[:child][:birthday]
    params[:child][:birthday] = Date.strptime(birthday, '%m/%d/%Y') if birthday.present?
    if @baby
      @baby.attributes = params[:child]
    else
      @baby = Baby.new params[:child]
    end
    @baby.user_id = current_user.id
    if @baby.save
      return redirect_to step_4_redeems_path(:redeem_id => params[:redeem_id])
    else
      render :action => :step_3
    end

  end

  def update_redeem_billing

  end

  def step_4
    @redeem = Redeem.new unless @redeem
    @redeem.build_billing_address unless @redeem.billing_address
    # @gift = Gift.new
    # @gift.build_billing_address unless @gift.billing_address

    # if @redeem.nil?
    #   redirect_to step_1_gifts_path(:submit => false)
    # elsif @reddem.plan_type.nil?
    #   redirect_to step_2_gifts_path(:gift_id => @gift.id,:submit => false)
    # else
    #   @redeem.build_billing_address unless @redeem.billing_address
    # end

  end

  def step_5
     @redeem = Redeem.new unless @redeem

  end

  def finish

  end

  protected
    def complete_checking
      @redeem = Redeem.find_by_id params[:redeem_id]
    end

end
