module EnrolmentHelper
# start: for devise login using
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
# end: for devise login using

  def enroll_path(step)
    options = {
      :controller => :enrolment,
      :action => step.to_sym,
      :only_path => true
    }
    if @order and @order.id
      options[:order_id] = @order.id
    else
      options[:baby_id] = @baby.id if @baby and @baby.id
    end
    url_for(options)
  end

  def gender_image_options(selected)
    [
      [Baby::GENDER[:boy],
        "<div class='icon-gender boy pull-left #{'selected' if selected== Baby::GENDER[:boy]}'></div>".html_safe] ,
      [Baby::GENDER[:girl],
        "<div class='icon-gender girl pull-left #{'selected' if selected== Baby::GENDER[:girl]}'></div>".html_safe],
      [Baby::GENDER[:surprize],
        "<div class='icon-gender surprize pull-left #{'selected' if selected== Baby::GENDER[:surprize]}'></div>".html_safe]
    ]
  end

  def plan_image_options(selected)
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
