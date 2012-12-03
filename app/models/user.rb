class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me
  validates :email, :password, :password_confirmation,  :presence => true
  # attr_accessible :title, :body
  # after_create :email_user

  # def email_user
  #   puts "================ email to user ============="
  #   u = "abc"
  #   # resource = build_resource
  #   UserMailer.welcom_email(u).deliver
  # end

end
