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
      redirect_to user_contact_path
    else
      puts @user.errors.inspect
      redirect_to user_contact_path
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
      redirect_to user_contact_path
    else
      @user = current_user
      render :action => :edit_password
    end
  end

end
