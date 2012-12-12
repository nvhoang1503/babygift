class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me
  validates :email, :password, :password_confirmation,  :presence => { :message => "Can't be blank." }
  # attr_accessible :title, :body
  # after_create :email_user

  ADMIN_EMAIL = 'littlesparktesting@gmail.com'


  belongs_to :shipping_address,
    :class_name => 'Address', :foreign_key => :shipping_id
  belongs_to :billing_address,
    :class_name => 'Address', :foreign_key => :billing_id
  accepts_nested_attributes_for :shipping_address, :billing_address
end
