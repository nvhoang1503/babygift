class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :first_name, :last_name, :phone, :state, :zip
  validates :address_1, :city, :first_name, :last_name, :state, :zip, :presence => { :message => "Can't be blank." }

  validates :zip, :format => { :with => /^\d{5}(-\d{4})?$/, :message => 'format must be "12345" or "12345-1234"'}
  validates :phone, :format => { :with => /^\d{3}-\d{3}-\d{4}$/, :message => 'format must be "123-123-1234"'}, :allow_blank => true

  def fullname
    [self.first_name, self.last_name].join(' ')
  end
end
