class AdminController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  # before_filter :authenticate_user!
  before_filter :export_environment, :only => [:user_export, :enroll_export, :gift_export, :redeem_export  ]

  layout 'export_layout', :only => [:user_export, :enroll_export, :gift_export, :redeem_export]

  def index
    if user_signed_in?
    else
      @submit_from = SessionsController::ADMIN_RECEIVE
    end
  end

  def user_export
    @users = User.order('created_at desc')
  end

  def enroll_export
    @orders = Order.order('created_at desc')
  end

  def gift_export
    @gifts = Gift.order('created_at desc')
  end

  def redeem_export
    @redeems = Redeem.order('created_at desc')
  end

  def export_environment
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="export_1.xls"'
    headers['Cache-Control'] = ''
  end

  def init
  end

end
