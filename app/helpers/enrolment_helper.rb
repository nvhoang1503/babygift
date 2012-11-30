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

  def gender_image_options
    [
      [1, '<div class="icon-gender boy pull-left"></div>'.html_safe] ,
      [-1, '<div class="icon-gender girl pull-left"></div>'.html_safe],
      [0, '<div class="icon-gender surprize pull-left"></div>'.html_safe]
    ]
  end

  def plan_image_options
    [
      [BabyPlan::TYPE['1_mon'],
        "<div class='icon-plan _1-month pull-left'>
          <div class='price'>
            #{ number_to_currency BabyPlan::PRICE[BabyPlan::TYPE['1_mon']]
            }#{I18n.t('content.page.enroll_2.monthly')}
          </div>
        </div>".html_safe] ,
      [BabyPlan::TYPE['3_mon'],
        "<div class='icon-plan _3-month pull-left'>
          <div class='price'>
            #{ number_to_currency BabyPlan::PRICE[BabyPlan::TYPE['3_mon']] }
          </div>
        </div>".html_safe] ,
      [BabyPlan::TYPE['6_mon'],
        "<div class='icon-plan _6-month pull-left'>
          <div class='price'>
            #{ number_to_currency BabyPlan::PRICE[BabyPlan::TYPE['6_mon']] }
          </div>
        </div>".html_safe] ,
      [BabyPlan::TYPE['12_mon'],
        "<div class='icon-plan _12-month pull-left'>
          <div class='price'>
            #{ number_to_currency BabyPlan::PRICE[BabyPlan::TYPE['12_mon']] }
          </div>
        </div>".html_safe]
    ]
  end
end
