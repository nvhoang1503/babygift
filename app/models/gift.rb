class Gift < ActiveRecord::Base
  EMAIL_REG_EXP = /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$/i

  attr_accessible :plan_type, :sender_email, :note, :recipient_email
  validates :sender_email, :recipient_email , :presence => {:message => "Can't be blank"}, :format => {:with => EMAIL_REG_EXP, :message => 'Invalid email'}

  belongs_to :shipping_address, :class_name => 'Address'
  belongs_to :billing_address, :class_name => 'Address'
end
