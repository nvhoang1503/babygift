class UsersController < ApplicationController
  layout 'account'
  before_filter :authenticate_user!

  def my_account
    @user = current_user
    @billing_address = @user.billing_address
    @plans = @user.plans
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
    @orders = Order.order_by_user(current_user.id)
  end

  def order_history_detail
    @order = Order.find params[:order_id]
  end

  def child_n_plan
    @user = current_user
    @plans = @user.plans.order("id")
  end

  def edit_child_n_plan
    @user = current_user
    @plan = Order.find_by_id(params[:plan_id])
    @childs = current_user.babies.select{|b| b.plan}
    @child = @plan.baby
    @child.birthday = @child.birthday.strftime('%m/%d/%Y') if @child.birthday
  end

  def update_child_n_plan
    @plan = Order.find_by_id params[:plan_id]
    if @plan
      params[:plan][:baby_attributes][:birthday] = Date.strptime(params[:plan][:baby_attributes][:birthday], '%m/%d/%Y') if params[:plan][:baby_attributes][:birthday].present?
      if @plan.update_attributes(params[:plan])
        redirect_to :action => :child_n_plan
      else
        @user = current_user
        @childs = current_user.babies
        @child = @plan.baby
        @child.birthday = @child.birthday.strftime('%m/%d/%Y') if @child.birthday

        render :action => :edit_child_n_plan, :plan_id => @plan.id
      end
    else
      redirect_to :action => :child_n_plan
    end
  end

  def reload_plan
    baby_id = params[:baby_id].to_i
    child = Baby.find_by_id(baby_id)
    if child
      result = child.attributes
      result[:birthday] = child.birthday.strftime('%m/%d/%Y')
      result[:plan] = child.plan.plan_detail_with_price
      render :json => {:success => true, :data => result}
    else
      render :json => {:success => false, :msg => I18n.t('message.not_found', :obj => 'This child')}
    end
  end
end
