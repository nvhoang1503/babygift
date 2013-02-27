class AdminController < ApplicationController
  before_filter :authenticate_admin_user
  before_filter :export_environment, :only => [:user_export, :enroll_export, :gift_export, :redeem_export  ]

  layout 'export_layout', :only => [:user_export, :enroll_export, :gift_export, :redeem_export]

  def login
    @submit_from = SessionsController::ADMIN_RECEIVE
  end

  def index
  end

  def user_export
    headers['Content-Disposition'] = 'attachment; filename="users.xls"'
    @users = User.order('created_at desc')
  end

  def enroll_export
    headers['Content-Disposition'] = 'attachment; filename="enrolls.xls"'
     @orders = Order.where("transaction_status" => Order::TRANSACTION_STATUS[:completed].to_s).order('created_at desc')
  end

  def gift_export
    headers['Content-Disposition'] = 'attachment; filename="gifts.xls"'
    @gifts = Gift.where("transaction_status" => Order::TRANSACTION_STATUS[:completed].to_s).order('created_at desc')
  end

  def redeem_export
    headers['Content-Disposition'] = 'attachment; filename="redeems.xls"'
    @redeems = Redeem.where("transaction_status" => Order::TRANSACTION_STATUS[:completed].to_s).order('created_at desc')
  end

  def export_environment
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Cache-Control'] = ''
  end

  def authenticate_admin_user
    if user_signed_in?
      if !current_user.is_admin?
        flash[:notice] = "You do not have permission to access admin page!"
        redirect_to root_path
      end

    else
      redirect_to(:action => :login) if params[:action]!= 'login'
    end
  end

end
