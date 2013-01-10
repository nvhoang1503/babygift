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
      @child = @childs.first
      @child.birthday = @child.birthday.strftime('%m/%d/%Y')
    end
  end

  def reload_child
    baby_id = params[:baby_id].to_i
    child = Baby.find_by_id(baby_id)
    if child
      result = child.attributes
      result[:birthday] = child.birthday.strftime('%m/%d/%Y')
      render :json => {:success => true, :data => result}
    else
      render :json => {:success => false, :msg => I18n.t('message.not_found', :obj => 'This child')}
    end
  end

  def update_child
    @child = Baby.find_by_id params[:child_id]
    if @child
      params[:child][:birthday] = Date.strptime(params[:child][:birthday], '%m/%d/%Y') if params[:child][:birthday].present?
      if @child.update_attributes(params[:child])
        @redeem.update_attribute(:baby_id,@child.id)
        redirect_to step_4_redeems_path(:redeem_id => @redeem.id)
      else
        if current_user.babies.count == 0
          return redirect_to step_3_redeems_path(:redeem_id => params[:redeem_id])
        else
          @childs = current_user.babies
          @child.birthday = @child.birthday.strftime('%m/%d/%Y') if @child.birthday
        end
        render :action => :step_3b
      end
    else
      redirect_to step_3b_redeems_path
    end
  end

  def create_child
    birthday = params[:child][:birthday]
    params[:child][:birthday] = Date.strptime(birthday, '%m/%d/%Y') if birthday.present?
    @baby = Baby.new params[:child]
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
