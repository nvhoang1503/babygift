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

  def self.an_process(price, params)
    card_num = params[:card_number]
    card_sec = params[:card_security]
    card_type = CARD_NAME[params[:card_type]]
    exp_date = Date.civil params[:date][:exp_year].to_i, params[:date][:exp_month].to_i

    transaction = AuthorizeNet::AIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], :gateway => :sandbox)

    address = Address.find_by_id params[:billing_address_id]
    shipping_address = Address.find_by_id params[:shipping_address_id]
    transaction.set_address address.to_AN_billing_address if address
    transaction.set_shipping_address shipping_address.to_AN_billing_address if shipping_address

    credit_card = AuthorizeNet::CreditCard.new card_num, exp_date.strftime('%m%y'), :card_code => card_sec, :card_type => card_type
    return transaction.purchase(price, credit_card)
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

end
