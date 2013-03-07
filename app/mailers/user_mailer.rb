class UserMailer < ActionMailer::Base
  layout 'email'

  default from: "Little Spark"

  def initial
    @logo_link = root_url.to_s + 'assets/common/logo_text.png'
    @btn_account_bg = root_url.to_s + 'assets/common/btn_account.png'
    @btn_gift_bg = root_url.to_s + 'assets/common/btn_gift.png'
  end

	def welcome_email(user)
    initial
	  @email = user.email
    @password = user.password
    @url = url_for :controller=>'sessions', :action=>'new'
    mail(:to => @email, :subject => "Welcome to Little Spark")
	end

  def register_mail(user)
    initial
    @user = user
    @user_mail = user.email
    @user_id = user.id
    @email = User::ADMIN_EMAIL
    mail(:to => @email ,subject: "New User" )
  end

  def order_confirm(user, order ,params , trans_id)
    initial
    @user = user
    @user_email = user.email
    @trans_id = trans_id
    @order = order
    @params = params
    @billing_address = @order.billing_address
    @shipping_address = @order.shipping_address
    @url = url_for :controller=>'sessions', :action=>'new'
    mail(:to => @user_email, :subject => "Order Confirmation")
  end

  def order_confirm_to_admin(user, order ,params , trans_id)
    initial
    @user = user
    @admin_email = User::ADMIN_EMAIL
    @user_email = user.email
    @trans_id = trans_id
    @order = order
    @params = params
    @billing_address = @order.billing_address
    @shipping_address = @order.shipping_address
    @url = url_for :controller=>'sessions', :action=>'new'
    mail(:to => @admin_email, :subject => "Order Confirmation")
  end

  def gift_confirm_to_admin(gift, params , trans_id)
    initial
    @gift = gift
    @admin_email = User::ADMIN_EMAIL
    @trans_id = trans_id
    @params = params
    @billing_address = @gift.billing_address
    @url = url_for :controller=>'home', :action=>'index'
    mail(:to => @admin_email, :subject => "Gift Confirmation")
  end

  def gift_confirm_to_sender(gift ,params , trans_id)
    initial
    @gift = gift
    @admin_email = User::ADMIN_EMAIL
    @trans_id = trans_id
    @params = params
    @billing_address = @gift.billing_address
    @url = url_for :controller=>'home', :action=>'index'
    mail(:to => @gift.sender_email, :subject => "Gift Giver Confirmation")
  end

  def gift_confirm_to_recipient(gift, params , trans_id)
    initial
    @gift = gift
    @url = url_for :controller=>'redeems', :action=>'step_1'
    mail(:to => @gift.recipient_email, :subject => "You've reveived a gift from #{@gift.sender_email}")

  end

  def redeem_confirm_to_admin(redeem)
    initial
    @redeem = redeem
    @admin_email = User::ADMIN_EMAIL
    @shipping_address = @redeem.shipping_address
    @billing_address = @redeem.billing_address
    @url = url_for :controller=>'home', :action=>'index'
    mail(:to => @admin_email, :subject => "Redeem Confirmation")
  end

  def redeem_confirm_to_recipient(redeem)
    initial
    @redeem = redeem
    @user = @redeem.baby.parent
    mail(:to => @user.email, :subject => "Thank you for redeeming your Little Spark gift!")

  end

end
