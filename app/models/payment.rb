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

  def self.an_process(params)
    card_num = params[:card_number]
    card_sec = params[:card_security]
    exp_date = Date.civil params[:date][:exp_year].to_i, params[:date][:exp_month].to_i

    transaction = AuthorizeNet::AIM::Transaction.new(AUTHORIZE_NET_CONFIG['api_login_id'], AUTHORIZE_NET_CONFIG['api_transaction_key'], :gateway => :sandbox)
    credit_card = AuthorizeNet::CreditCard.new card_num, exp_date.strftime('%m%y')
    return transaction.purchase('10.00', credit_card)
	end
end
