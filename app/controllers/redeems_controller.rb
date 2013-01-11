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
      if @redeem.update_attribute(:redeem_status, Redeem::STATUS[:start])
        redirect_to step_2_redeems_path(:redeem_id => @redeem.id)
      else
        flash[:error] = I18n.t('message.fail_redeem')
        redirect_to step_1_redeems_path
      end
    else
      @redeem = Redeem.new
      @redeem.errors.add('gift_code', I18n.t('message.gift_code_incorrect'))
      params[:gift_code] = gift_code
      render step_1_redeems_path
    end
  end

  def step_2
    if @redeem
      @submit_from = RegistrationsController::REDEEM_RECEIVE
      if user_signed_in?
        return redirect_to step_3b_redeems_path(:redeem_id => params[:redeem_id])
      end
    else
      return redirect_to step_1_redeems_path(:submit => false)
    end
  end

   def step_3
    @baby = Baby.new
  end

  def step_3b
    if @redeem
      if user_signed_in?
        if current_user.babies.count == 0
          return redirect_to step_3_redeems_path(:redeem_id => params[:redeem_id], :submit => params[:submit])
        else
          @childs = current_user.babies
          @child = @childs.first
          @child.birthday = @child.birthday.strftime('%m/%d/%Y')
        end
      else
        return redirect_to step_2_redeems_path(:submit => false, :redeem_id => params[:redeem_id])
      end
    else
      return redirect_to step_1_redeems_path(:submit => false)
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
      redirect_to step_3b_redeems_path(:redeem_id => params[:redeem_id])
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

  def step_4
    if @redeem
      if @redeem.baby
        @redeem.build_shipping_address unless @redeem.shipping_address
      else
        return redirect_to step_3b_redeems_path(:redeem_id => params[:redeem_id],:submit => false)
      end
    else
      return redirect_to step_1_redeems_path(:submit => false)
    end
  end

  def update_redeem_shipping
    info = params[:redeem][:shipping_address_attributes]
    if @redeem.shipping_address.nil?
      @redeem.build_shipping_address(info)
    else
      @redeem.shipping_address.attributes = info
    end

    if @redeem.save
      redirect_to step_5_redeems_path(:redeem_id => @redeem.id)
    else
      render step_4_redeems_path
    end
  end


  def step_5
     # @redeem = Redeem.new
     if @redeem
      unless @redeem.shipping_address
        return redirect_to step_4_redeems_path(:redeem_id => params[:redeem_id],:submit => false)
      end
     else
      return redirect_to step_1_redeems_path(:submit => false)
     end
  end

  def finish
    @redeem.redeem_status = Redeem::STATUS[:completed]
    @redeem.redeem_date = Time.now
    if @redeem.save
      UserMailer.redeem_confirm_to_admin(@redeem).deliver
      UserMailer.redeem_confirm_to_recipient(@redeem).deliver
    else
      flash[:error] = I18n.t('message.fail_redeem')
      redirect_to step_5_redeems_path(:redeem_id => @redeem.id)
    end
  end

  protected
    def complete_checking
      @redeem = Redeem.find_by_id params[:redeem_id]
      if @redeem && @redeem.redeem_status==Redeem::STATUS[:completed]
        flash[:warning] = I18n.t('message.invalid_gift')
        redirect_to step_1_redeems_path
      end
    end
end
