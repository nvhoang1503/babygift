class UserMailer < ActionMailer::Base
  default from: "from@example.com"


	def welcome_email(user)
	  @email = user.email
    @password = user.password
    @url = url_for :controller=>'devise/sessions', :action=>'new'
    mail(:to => @email, :subject => "Welcome to Little Spark")
	end

  def register_mail(user)
    @user = user
    @user_mail = user.email
    @user_id = user.id
    @email = "littlesparktesting@gmail.com"
    mail(:to => @email ,subject: "New User" )
  end
end
