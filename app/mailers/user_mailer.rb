class UserMailer < ActionMailer::Base
  default from: "from@example.com"

	def welcome_email(user)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
	  @email = user.email
    @password = user.password
    @url = url_for :controller=>'devise/sessions', :action=>'new'
    mail(:to => @email, :subject => "Welcome to Little Spark")
	end

  def register_mail(user)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @user = user
    @user_mail = user.email
    @user_id = user.id
    @email = "littlesparktesting@gmail.com"
    mail(:to => @email ,subject: "New User" )
  end

  def enroll_email(user, order ,params , trans_id)
    @image_link = root_url.to_s + 'assets/common/logo_text.png'
    @user = user
    @user_email = user.email
    @trans_id = trans_id
    @order = order

    mail(:to => @user_email, :subject => "Congratulation!")
  end

end
