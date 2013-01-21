class UsersController < ApplicationController
  layout 'account'

  def my_account
  end

  def contact
    @user = current_user
  end

  def contact_update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      redirect_to user_contact_path
    else
      puts @user.error
      redirect_to user_contact_path
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
  end


end
