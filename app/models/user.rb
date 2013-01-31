class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  EMAIL_REG_EXP = /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$/i

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name,:email_notification, :email, :email_confirmation, :password, :password_confirmation, :remember_me

  validates :email, :password, :presence => { :message => "Can't be blank" }
  validates :first_name, :last_name , :presence => { :message => "Can't be blank" }, :on => :update

  validates :email, :format => {:with => EMAIL_REG_EXP, :message => I18n.t('message.invalid_email')}



  # validates :password,  :presence => { :message => "Can't be blank" },:unless => lambda {|u| u.password.nil? }
  # validates :password,  :length => {:maximum => 20, :minimum => 6, :message => I18n.t('message.pass_format')},:unless => lambda {|u| u.password.nil? }

  validates :password,  :length => {:maximum => 20, :minimum => 6, :message => I18n.t('message.pass_format')}

  ADMIN_EMAIL = 'littlesparktesting@gmail.com'

  has_many :babies
  has_many :plans, :through => :babies, :conditions => ["orders.transaction_status like '#{Order::TRANSACTION_STATUS[:completed]}'"]
  has_many :redeems, :through => :babies, :conditions => ["gifts.redeem_status like '#{Redeem::STATUS[:completed]}'"]
  belongs_to :shipping_address,
    :class_name => 'Address', :foreign_key => :shipping_id
  belongs_to :billing_address,
    :class_name => 'Address', :foreign_key => :billing_id
  accepts_nested_attributes_for :shipping_address, :billing_address

  def enroll_n_redeem_babies
    enroll_babies_selector = self.babies.joins(:plan).where("orders.transaction_status like '#{Order::TRANSACTION_STATUS[:completed]}'").select('babies.*, orders.plan_type AS plan_type, orders.price AS price, orders.id AS plan_id, true AS is_enroll_plan, false AS is_redeem_plan').to_sql
    redeem_babies_selector = self.babies.joins(:redeem).where("gifts.redeem_status like '#{Redeem::STATUS[:completed]}'").select('babies.*, gifts.plan_type as plan_type, gifts.price as price, gifts.id AS plan_id, false AS is_enroll_plan, true AS is_redeem_plan').to_sql
    sql = "#{enroll_babies_selector} UNION ALL #{redeem_babies_selector}"

    return Baby.find_by_sql(sql)
  end

  def fullname
    if self.first_name == "" && self.last_name == ""
      return nil
    else
      return [self.first_name, self.last_name].join(" ")
    end
  end

  def displayed_name
    name = fullname.nil? ? email : fullname
  end

  def first_name
    if self['first_name'] == nil
      self['first_name'] = ""
    end
    return self['first_name']
  end

  def last_name
    if self['last_name'] == nil
      self['last_name'] = ""
    end
    return self['last_name']
  end

end




