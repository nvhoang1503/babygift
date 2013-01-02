module GiftsHelper
  def gift_plan_image_options(selected)
    [
      [Order::TYPE['1_mon'],
        "<div class='icon-plan _1-month pull-left  #{'selected' if selected== Order::TYPE['1_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['1_mon']]
            }#{I18n.t('content.page.enroll_2.monthly')}
          </div>
        </div>".html_safe] ,
      [Order::TYPE['3_mon'],
        "<div class='icon-plan _3-month pull-left  #{'selected' if selected== Order::TYPE['3_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['3_mon']] }
          </div>
        </div>".html_safe] ,
      [Order::TYPE['6_mon'],
        "<div class='icon-plan _6-month pull-left  #{'selected' if selected== Order::TYPE['6_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['6_mon']] }
          </div>
        </div>".html_safe] ,
      [Order::TYPE['12_mon'],
        "<div class='icon-plan _12-month pull-left  #{'selected' if selected== Order::TYPE['12_mon']}'>
          <div class='price'>
            #{ number_to_currency Order::PRICE[Order::TYPE['12_mon']] }
          </div>
        </div>".html_safe]
    ]
  end
end
