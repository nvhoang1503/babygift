class UsersController < ApplicationController
  layout 'account'
  before_filter :authenticate_user!

  def my_account
    @billing_address = current_user.billing_address
    @babies = current_user.enroll_n_redeem_babies

  end

  def contact
    @user = current_user
  end

  def contact_update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save(:validate=> false)
      flash[:success] = I18n.t('content.page.account_contact.saved')
      redirect_to my_account_path
    else
      # puts @user.errors.inspect
      redirect_to contact_users_path
    end
  end

  def edit_password
    @user = current_user
  end

  def update_acount_password
    @user = current_user
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      flash[:notice] = 'Password updated.'
      redirect_to contact_users_path
    else
      @user = current_user
      render :action => :edit_password
    end
  end

  def order_history
    @orders = Order.order_redeem_by_user(current_user.id)
  end

  def order_history_detail
    id = params[:order_id].to_i
    @order_type = params[:order_type].to_i
    # @order = Order.find params[:order_id]
    @order = Order.order_redeem_detail(id,@order_type)
    if current_user.id != @order.baby.parent.id
      flash[:error] = 'Incorrect order'
      redirect_to :action => :order_history
    end
  end

  def child_n_plan
    @babies = current_user.enroll_n_redeem_babies
  end

  def edit_child_n_plan
    @babies = current_user.enroll_n_redeem_babies
    @baby = current_user.get_baby_by_plan(params[:plan_id], params[:enroll], params[:redeem])
    @baby.birthday = @baby.birthday.strftime('%m/%d/%Y') if @baby.birthday
  end

  def update_child_n_plan
    @baby = current_user.get_baby_by_plan(params[:plan_id], params[:enroll], params[:redeem])
    if @baby
      params[:baby][:birthday] = Date.strptime(params[:baby][:birthday], '%m/%d/%Y') if params[:baby][:birthday].present?
      if @baby.update_attributes(params[:baby])
        redirect_to :action => :child_n_plan
      else
        @babies = current_user.enroll_n_redeem_babies
        @baby = current_user.get_baby_by_plan(params[:plan_id], params[:enroll], params[:redeem])
        @baby.birthday = @baby.birthday.strftime('%m/%d/%Y') if @baby.birthday
        render :action => :edit_child_n_plan, :plan_id => @plan.id, :enroll => @baby.is_enroll_plan, :redeem => @baby.is_redeem_plan
      end
    else
      redirect_to :action => :child_n_plan
    end
  end

  def reload_plan
    baby = current_user.get_baby_by_plan(params[:plan_id], params[:enroll], params[:redeem])
    if baby
      result = baby.attributes
      result[:birthday] = baby.birthday.strftime('%m/%d/%Y')
      result[:plan] = "#{Order::TYPE_DUR[baby.plan_type.to_i]} $#{Order::PRICE[baby.plan_type.to_i]}"
      render :json => {:success => true, :data => result}
    else
      render :json => {:success => false, :msg => I18n.t('message.not_found', :obj => 'This child')}
    end
  end

  def cancel_plan
    result = {}
    plan = Order.find_by_id params[:plan_id]
    if plan
      response = Payment.an_cancel_recurring(plan.subscription_id)
      if response.success?
        result[:success] = true
        result[:msg] = I18n.t('message.success_cancel_plan')
      else
        result[:success] = false
        result[:msg] = I18n.t('message.fail_cancel_plan')
      end
    else
      result[:success] = false
    end
    render :json => result
  end

end
