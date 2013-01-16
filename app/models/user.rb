class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :email_confirmation, :password, :password_confirmation, :remember_me
  validates :email,:password,  :presence => { :message => "Can't be blank" }

  validates :password,  :length => {:maximum => 20, :minimum => 6, :message => I18n.t('message.pass_format')}

  ADMIN_EMAIL = 'littlesparktesting@gmail.com'


  has_many :babies
  belongs_to :shipping_address,
    :class_name => 'Address', :foreign_key => :shipping_id
  belongs_to :billing_address,
    :class_name => 'Address', :foreign_key => :billing_id
  accepts_nested_attributes_for :shipping_address, :billing_address

end
