class UserMailer < ActionMailer::Base
  default from: "from@example.com"

	def welcome_email(user)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
	  @email = user.email
    @password = user.password
    @url = url_for :controller=>'sessions', :action=>'new'
    mail(:to => @email, :subject => "Welcome to Little Spark")
	end

  def register_mail(user)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @user = user
    @user_mail = user.email
    @user_id = user.id
    @email = User::ADMIN_EMAIL
    mail(:to => @email ,subject: "New User testing" )
  end

  def order_confirm(user, order ,params , trans_id)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
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
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
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
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @gift = gift
    @admin_email = User::ADMIN_EMAIL
    @trans_id = trans_id
    @params = params
    @billing_address = @gift.billing_address
    @url = url_for :controller=>'home', :action=>'index'
    mail(:to => @admin_email, :subject => "Gift Confirmation")
  end

  def gift_confirm_to_sender(gift ,params , trans_id)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @gift = gift
    @admin_email = User::ADMIN_EMAIL
    @trans_id = trans_id
    @params = params
    @billing_address = @gift.billing_address
    @url = url_for :controller=>'home', :action=>'index'
    mail(:to => @gift.sender_email, :subject => "Gift Giver Confirmation")
  end

  def gift_confirm_to_recipient(gift, params , trans_id)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @gift = gift
    @admin_email = User::ADMIN_EMAIL
    @params = params
    @url = url_for :controller=>'redeems', :action=>'step_1'
    mail(:to => @gift.recipient_email, :subject => "Gift Recipient Notification")

  end

  def redeem_confirm_to_admin(redeem)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @redeem = redeem
    @admin_email = User::ADMIN_EMAIL
    @shipping_address = @redeem.shipping_address
    @billing_address = @redeem.billing_address
    @url = url_for :controller=>'home', :action=>'index'
    mail(:to => @admin_email, :subject => "Redeem Confirmation")
  end

  def redeem_confirm_to_recipient(redeem)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @redeem = redeem
    @admin_email = User::ADMIN_EMAIL
    @url = url_for :controller=>'home', :action=>'index'
    @user = @redeem.baby.parent
    mail(:to => @user.email, :subject => "Redeem Recipient Notification")

  end
end
