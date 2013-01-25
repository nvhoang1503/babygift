Then /^I should see the title of Children and Plan page$/ do
  check_label('.page-title', I18n.t("content.page.account_child_plan.title").upcase, '22px', "'GudeaBold'", "rgb(47, 180, 149)")
end

Then /^I should see the title of page in the left menu highlighted$/ do
  check_label('#account_child_plan a', I18n.t("content.page.account_child_plan.step"), '18px', "'GudeaBold'", "rgb(68, 70, 75)")
end

Then /^I should see the list of children's header$/ do
  check_label('#list-children .header .name', I18n.t("label.name").upcase, '13px', "'GudeaBold'", "rgb(68, 70, 75)")
  check_label('#list-children .header .birthday', I18n.t("label.birthday").upcase, '13px', "'GudeaBold'", "rgb(68, 70, 75)")
  check_label('#list-children .header .plan', I18n.t("label.plan").upcase, '13px', "'GudeaBold'", "rgb(68, 70, 75)")
end


Then /^I should see the list of my children in the middle section$/ do
  @current_user.plans.each do |pl|
    ele = "#plan-#{pl.id}"
    name = pl.baby.fullname
    birthday = pl.baby.birthday.strftime('%m/%d/%Y')
    plan = plan_detail(pl.plan_type, pl.price)
    check_label("#{ele} .name", name, '16px', '"Gudea",serif', "rgb(68, 70, 75)")
    check_label("#{ele} .birthday", birthday, '16px', '"Gudea",serif', "rgb(68, 70, 75)")
    check_label("#{ele} .plan", plan, '16px', '"Gudea",serif', "rgb(68, 70, 75)")
    check_text("#{ele} a", I18n.t('label.edit'))
    # sleep 5
    # find("#{ele} a").click
    #check_label('.page-title', I18n.t("content.page.edit_child_plan.title").upcase, '22px', "'GudeaBold'", "rgb(47, 180, 149)")
  end
end

Then /^I should see text and link in the bottom of page to enroll a new child$/ do
  check_label("#action span", I18n.t('content.page.account_child_plan.add_another'), '16px', "\"GudeaBold\"", "rgb(68, 70, 75)")
  check_label("#action a", I18n.t('content.page.account_child_plan.sign_up'), '16px', '"Gudea",serif', "rgb(47, 180, 149)")
end

When /^I click on Sign him or her up here$/ do
  find("#action a").click
end

Then /^I should see the title of Enroll page$/ do
  check_label('.tittle_content', I18n.t("content.page.enroll_1.title"), '26px', "\"GudeaBold\"", "rgb(47, 180, 149)")
end

When /^clicking on edit link of first child$/ do
  pl = @current_user.plans.first
  find("#plan-#{pl.id} a").click
end

Then /^I should see the title of Children and Plan edition page$/ do
  check_label('.page-title', I18n.t("content.page.edit_child_plan.title").upcase, '22px', "'GudeaBold'", "rgb(47, 180, 149)")
end

Then /^I should see the child form in the middle section$/ do
  check_label('#meo', I18n.t("content.page.account_child_plan.which_child", '18px', "'GudeaBold'", "rgb(68, 70, 75)"))
end

Then /^I should see the cancel button$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the save button$/ do
  pending # express the regexp above with the code you wish you had
end


