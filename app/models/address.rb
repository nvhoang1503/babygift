class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :first_name, :last_name, :phone, :state, :zip
  validates :address_1, :city, :first_name, :last_name, :state, :zip, :phone, :presence => { :message => "Can't be blank." }

  validates :zip, :format => { :with => /^\d{5}(-\d{4})?$/, :message => I18n.t('message.zip_format')}
  validates :phone, :format => { :with => /^\d{10}$/, :message => I18n.t('message.phone_invalid')}
  # validate :validate_phone_format

  def fullname
    [self.first_name, self.last_name].join(' ')
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

  # protected
  #   def validate_phone_format
  #     val = self.phone.gsub(/\s*/, '')
  #     if !val.blank?
  #       if val.index('--')
  #         self.errors.add('phone', I18n.t('message.phone_format'))
  #       elsif val.index('-')
  #         val = val.gsub(/-/,'')
  #         if (val =~ /^\d{5,15}$/).nil?
  #           self.errors.add('phone', I18n.t('message.phone_format'))
  #           return false
  #         end
  #       else
  #         if (val =~ /^\d{5,15}$/).nil?
  #           self.errors.add('phone', I18n.t('message.phone_invalid'))
  #           return false
  #         end
  #       end
  #     end
  #   end
end
