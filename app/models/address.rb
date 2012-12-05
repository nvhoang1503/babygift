class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :first_name, :last_name, :phone, :state, :zip
  validates_presence_of :address_1, :city, :first_name, :last_name, :phone, :state, :zip
  validates :zip, :format => { :with => /^\d{5}(-\d{4})?$/, :message => 'format must be "12345" or "12345-1234"'}
  validates :phone, :format => { :with => /^\d{3}-\d{3}-\d{4}$/, :message => 'format must be "123-123-12345"'}
end
