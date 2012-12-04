class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :first_name, :last_name, :phone, :state, :zip
  validates_presence_of :address_1, :city, :first_name, :last_name, :phone, :state, :zip
end
