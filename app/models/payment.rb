class Payment < ActiveRecord::Base
  CARD_TYPE = {
    :visa => 1,
    :master => 2,
    :am_express => 3,
    :discover => 4
  }
  CARD_NAME = {
    CARD_TYPE[:visa] => 'Visa',
    CARD_TYPE[:master] => 'Master Card',
    CARD_TYPE[:am_express] => 'American Express',
    CARD_TYPE[:discover] => 'Discover'
  }
  CCV_RESPONSE = {
    'N' => 'The security code does not match the card number',
    'P' => 'The security code was not processed',
    'S' => 'The security code was not indicated',
    'U' => 'The security code is not supported by the card issuer'
  }
  AVS_RESPONSE = {
    'N' => 'Neither the street address nor the 5-digit ZIP code matches the address and ZIP code on file for the card',
    'A' => 'The street address matches, but the 5-digit ZIP code does not',
    'Z' => 'The first 5 digits of the ZIP code matches, but the street address does not match',
    'W' => 'The 9-digit ZIP code matches, but the street address does not match',
    'Y' => 'The street address and the first 5 digits of the ZIP code match perfectly'

    # 'B' => 'Address information was not submitted in the transaction information, so AVS check could not be performed',
    # 'E' => 'The AVS data provided is invalid, or AVS is not allowed for the card type submitted',
    # 'G' => 'The credit card issuing bank is of non-U.S. origin and does not support AVS',
    # 'P' => 'AVS is not applicable for this transaction',
    # 'R' => 'AVS was unavailable at the time the transaction was processed. Retry transaction',
    # 'S' => 'The U.S. card issuing bank does not support AVS',
    # 'U' => "Address information is not available for the customer's credit card"
  }

  RECURRING_RESPONSE = {
    'E00001' => 'An error occurred during processing. Please try again.',
    'E00002' => 'An error occurred during processing. Please try again.',
    'E00003' => 'The card number/code is invalid.',
    'E00004' => 'An error occurred during processing. Please try again.',
    'E00005' => 'Merchant authentication requires a valid value for transaction key.',
    'E00006' => 'An error occurred during processing. Please try again.',
    'E00007' => 'An error occurred during processing. Please try again.',
    'E00008' => 'An error occurred during processing. Please try again.',
    'E00009' => 'The payment gateway account is in Test Mode. The request cannot be processed.',
    'E00010' => 'An error occurred during processing. Please try again.',
    'E00011' => 'An error occurred during processing. Please try again.',
    'E00012' => 'A duplicate subscription already exists',
    'E00017' => 'The startDate cannot occur in the past.',
    'E00018' => 'The credit card expires before the subscription startDate.',
    'E00021' => 'The payment gateway account is not enabled for credit card subscriptions.'
  }

  def self.an_process(price, params)
    card_num = params[:card_number]
    card_sec = params[:card_security]
    exp_date = Date.civil params[:date][:exp_year].to_i, params[:date][:exp_month].to_i

    if Rails.env == 'production'
      transaction = AuthorizeNet::AIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'])
    else
      transaction = AuthorizeNet::AIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], :gateway => :sandbox)
    end

    address = Address.find_by_id params[:billing_address_id]
    shipping_address = Address.find_by_id params[:shipping_address_id]
    transaction.set_address address.to_AN_billing_address if address
    transaction.set_shipping_address shipping_address.to_AN_shipping_address if shipping_address
    transaction.set_fields(:invoice_num => params[:order_code]) if params.has_key?(:order_code)

    credit_card = AuthorizeNet::CreditCard.new card_num, exp_date.strftime('%m%y'), :card_code => card_sec
    response = transaction.purchase(price.round(2), credit_card)
    Rails.logger.info '=============================AN process result================================'
    Rails.logger.info response.inspect
    Rails.logger.info '=============================END================================='
    return response
  end

  def self.get_error_messages(an_response)
    if an_response.success?
      result = nil
    else
      result = [an_response.response_reason_text]
      ccv_result = an_response.fields[:card_code_response]
      avs_result = an_response.fields[:avs_response]
      result.append CCV_RESPONSE[ccv_result] if CCV_RESPONSE.has_key?(ccv_result)
      result.append AVS_RESPONSE[avs_result] if AVS_RESPONSE.has_key?(avs_result)
    end
    return result
  end

  def self.get_recurring_error_messages(an_response)
    if an_response.success?
      result = nil
    else
      result = []
      if RECURRING_RESPONSE.has_key? an_response.message_code
        result.append RECURRING_RESPONSE[an_response.message_code]
      else
        result.append I18n.t('message.fail_enroll')
      end
    end
    return result
  end

  def self.an_create_recurring(price, params)
    card_num = params[:card_number]
    card_sec = params[:card_security]
    exp_date = Date.civil params[:date][:exp_year].to_i, params[:date][:exp_month].to_i
    credit_card = AuthorizeNet::CreditCard.new card_num, exp_date.strftime('%m%y'), :card_code => card_sec

    if Rails.env == 'production'
      transaction = AuthorizeNet::ARB::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'])
    else
      transaction = AuthorizeNet::ARB::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], :gateway => :sandbox)
    end

    address = Address.find_by_id params[:billing_address_id]
    shipping_address = Address.find_by_id params[:shipping_address_id]
    transaction.set_address address.to_AN_billing_address if address
    transaction.set_shipping_address shipping_address.to_AN_shipping_address if shipping_address

    subscription = AuthorizeNet::ARB::Subscription.new(
      :length => params[:cycle],
      :unit => :month,
      :start_date => Date.today,
      :total_occurrences => AuthorizeNet::ARB::Subscription::UNLIMITED_OCCURRENCES,
      :amount => price.round(2),
      :invoice_number => params[:order_code],
      :description => params[:description],
      :credit_card => credit_card,
    )
    response = transaction.create(subscription)

    Rails.logger.info '=============================AN process result================================'
    Rails.logger.info response.inspect
    Rails.logger.info '=============================END================================='
    return response
  end

  def self.an_cancel_recurring(subscription_id)
    if Rails.env == 'production'
      transaction = AuthorizeNet::ARB::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'])
    else
      transaction = AuthorizeNet::ARB::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], :gateway => :sandbox)
    end
    response = transaction.cancel(subscription_id)

    Rails.logger.info '=============================AN process result================================'
    Rails.logger.info response.inspect
    Rails.logger.info '=============================END================================='
    return response
  end

end
