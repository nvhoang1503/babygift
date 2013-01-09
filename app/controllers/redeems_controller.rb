class RedeemsController < ApplicationController
  before_filter :complete_checking

  def step_1
    @redeem = Redeem.new unless @redeem
  end

  def create_update
    info = params[:redeem]
    gift_code = params[:redeem][:gift_code]
    flag = true
    @redeem = Redeem.find_by_gift_code(gift_code)
    if @redeem
      redirect_to step_2_redeems_path(:redeem_id => @redeem.id)
    else
      @redeem = Redeem.new
      @redeem.errors.add('gift_code', I18n.t('message.gift_code_incorrect'))
      params[:gift_code] = gift_code
      render step_1_redeems_path
    end
  end

  def step_2
    @submit_from = RegistrationsController::REDEEM_RECEIVE
    if user_signed_in?
      return redirect_to step_3b_redeems_path(:redeem_id => params[:redeem_id])
    end
  end

   def step_3
    @baby = Baby.new
  end

  def step_3b
    if current_user.babies.count == 0
      return redirect_to step_3_redeems_path(:redeem_id => params[:redeem_id])
    else
      @childs = current_user.babies
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
      @redeem.update_attribute(:baby_id , @baby.id)
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
