class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :first_name, :last_name, :phone, :state, :zip
  validates :address_1, :city, :first_name, :last_name, :state, :zip, :phone, :presence => { :message => "Can't be blank" }

  validates :zip, :format => { :with => /^\d{5}(-\d{4})?$/, :message => I18n.t('message.zip_format')}
  validates :phone, :format => { :with => /^\d{10}$/, :message => I18n.t('message.phone_invalid')}

  def fullname
    [self.first_name, self.last_name].join(' ')
  end

  def city_state
    state = [self.state, self.zip].join(' ')
    return [self.city, state].join(', ')
  end

  def to_AN_billing_address
    return AuthorizeNet::Address.new({
      :first_name => self.first_name,
      :last_name => self.last_name,
      :company => nil,
      :street_address => self.address_1,
      :city => self.city,
      :state => self.state,
      :zip => self.zip,
      :country => 'USA',
      :phone => self.phone,
      :fax => nil,
      :customer_address_id => nil
    })
  end

  def to_AN_shipping_address
    return AuthorizeNet::ShippingAddress.new({
      :first_name => self.first_name,
      :last_name => self.last_name,
      :company => nil,
      :address => self.address_1,
      :city => self.city,
      :state => self.state,
      :zip => self.zip,
      :country => 'USA',
      :phone => self.phone,
      :fax => nil,
      :customer_address_id => nil
    })
  end

  def address_full
    [address_1, city_state].join(', ')
  end

  def address2_full
    add = nil
    if !address_2.blank?
      add = [address_2, city_state].join(', ')
    end
    return add
  end

end
