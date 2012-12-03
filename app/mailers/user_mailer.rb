class UserMailer < ActionMailer::Base
  default from: "from@example.com"


	def welcom_email(user)
	  # mail(to: self.email, subject: "Welcome Message")

    
    # @url = url_for :controller=>'devise/sessions', :action=>'new'
    mail(:to => self.email, :subject => "Welcome to Little Spark")

    puts "=========================================================="
	  puts " ================ nguyen van hoang put here ==================="
    puts "=========================================================="
	end
  
  def register_mail(user)
    @user = user
    mail(
      to: "hoangtesting@gmail.com",
      subject: "request for installation",
      from: @user,
      date: Time.now,
      content_type: "text/html"
    )
  end
end
