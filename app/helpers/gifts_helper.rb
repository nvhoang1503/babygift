module GiftsHelper
  def gift_plan_image_options(selected)
    [
      [Order::TYPE['1_mon'],
        "<div class='icon-plan _1-month pull-left  #{'selected' if selected== Order::TYPE['1_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['1_mon']]
            }
          </div>
        </div>
        <div class='info clearboth'>#{I18n.t('content.page.gift_2.text_bill_month1')}</div>
        ".html_safe] ,
      [Order::TYPE['3_mon'],
        "<div class='icon-plan _3-month pull-left  #{'selected' if selected== Order::TYPE['3_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['3_mon']] }
          </div>
        </div>
        <div class='info clearboth'>#{I18n.t('content.page.gift_2.text_bill_month2')}</div>
        ".html_safe] ,
      [Order::TYPE['6_mon'],
        "<div class='icon-plan _6-month pull-left  #{'selected' if selected== Order::TYPE['6_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['6_mon']] }
          </div>
        </div>
        <div class='info clearboth'>#{I18n.t('content.page.gift_2.text_bill_month2')}</div>
        ".html_safe] ,
      [Order::TYPE['12_mon'],
        "<div class='icon-plan _12-month pull-left  #{'selected' if selected== Order::TYPE['12_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['12_mon']] }
          </div>
        </div>
        <div class='info clearboth'>#{I18n.t('content.page.gift_2.text_bill_month2')}</div>
        ".html_safe]
    ]
  end

  def get_shipping_fullname(shipping_address_id)
    address = Address.find_by_id(shipping_address_id)
    fullname = ""
    if !( address.first_name.nil? && address.last_name.nill?)
      fullname = [address.first_name,address.last_name].join(" ")
    end
    return fullname
  end


end
