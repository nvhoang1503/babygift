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
    @childs = current_user.babies
    @child = @plan.baby
    @child.birthday = @child.birthday.strftime('%m/%d/%Y') if @child.birthday
  end

end
