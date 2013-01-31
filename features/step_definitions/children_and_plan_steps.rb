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

When /^clicking on edit link of last child$/ do
  pl = @current_user.plans.last
  find("#plan-#{pl.id} a").click
end

Then /^I should see the title of Children and Plan edition page$/ do
  check_label('.page-title', I18n.t("content.page.edit_child_plan.title").upcase, '22px', "'GudeaBold'", "rgb(47, 180, 149)")
end

Then /^I should see Which Child\? combo\-box$/ do
  check_text(".child_box", I18n.t("content.page.edit_child_plan.which_child"))
  page.evaluate_script("$('.form_field > label:first').css('font-size')").should == '16px'
  page.evaluate_script("$('.form_field > label:first').css('font-family')").should == "\"GudeaBold\""
  page.evaluate_script("$('.form_field > label:first').css('color')").should == "rgb(68, 70, 75)"
  check_text("#child_id", "ABC")
end

Then /^I should see Plan label$/ do
  check_text(".child_box", I18n.t("content.page.edit_child_plan.plan"))
  page.evaluate_script("$('.form_field > label').eq(4).css('font-size')").should == "16px"
  page.evaluate_script("$('.form_field > label').eq(4).css('font-family')").should == "\"GudeaBold\""
  page.evaluate_script("$('.form_field > label').eq(4).css('color')").should == "rgb(68, 70, 75)"
  check_text("#plan-info","1-month $34.99")
end

When /^I cancel this plan$/ do
  find("#btn-cancel").click
end

When /^I update the first name info to "(.*?)"$/ do |name|
  fill_in("plan_baby_attributes_first_name", :with => name)
  find("#btn-submit").click
end

Then /^I should see the cancel button in disabled status$/ do
  check_text("#btn-cancel.btn-gray", I18n.t("content.page.edit_child_plan.cancel").upcase)
  page.evaluate_script("$('#btn-cancel.btn-gray').css('background-color')").should == "rgb(162, 162, 162)"
end

Then /^I should see the cancel button in enabled status$/ do
  check_text("#btn-cancel.btn-green", I18n.t("content.page.edit_child_plan.cancel").upcase)
  page.evaluate_script("$('#btn-cancel.btn-green').css('background-color')").should == "rgb(47, 180, 149)"
end

Then /^I should see the save button$/ do
  page.evaluate_script("$('#btn-submit.btn-pink').val()").should == I18n.t("content.page.edit_child_plan.save")
  page.evaluate_script("$('#btn-submit.btn-pink').css('background-color')").should == "rgb(228, 47, 90)"
end

Then /^I should see Child's Name text\-box$/ do
  check_text(".child_box", I18n.t("content.page.redeem_3.child_name"))
  page.evaluate_script("$('.form_field > label').eq(1).css('font-size')").should == "16px"
  page.evaluate_script("$('.form_field > label').eq(1).css('font-family')").should == "\"GudeaBold\""
  page.evaluate_script("$('.form_field > label').eq(1).css('color')").should == "rgb(68, 70, 75)"

  field1 = find_field("plan_baby_attributes_first_name")
  field_value1 = (field1.tag_name == 'textarea') ? field1.text : field1.value
  if field_value1.respond_to? :should
    field_value1.should == "ABC"
  else
    assert_match(/#{value}/, field_value1)
  end

  field2 = find_field("plan_baby_attributes_last_name")
  field_value2 = (field2.tag_name == 'textarea') ? field2.text : field2.value
  if field_value2.respond_to? :should
    field_value2.should == "ABCD"
  else
    assert_match(/#{value}/, field_value2)
  end
end


Then /^I should see Child's Birthday box$/ do
  check_text(".child_box", I18n.t("content.page.redeem_3.child_birth"))
  page.evaluate_script("$('.form_field > label').eq(2).css('font-size')").should == '16px'
  page.evaluate_script("$('.form_field > label').eq(2).css('font-family')").should == "\"GudeaBold\""
  page.evaluate_script("$('.form_field > label').eq(2).css('color')").should == "rgb(68, 70, 75)"
  field = find_field("plan_baby_attributes_birthday")
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  if field_value.respond_to? :should
    field_value.should == "12/12/2012"
  else
    assert_match(/#{value}/, field_value)
  end
end

Then /^I should see Child's Gender combo\-box$/ do
  check_text(".child_box", I18n.t("content.page.redeem_3.child_gender"))
  page.evaluate_script("$('.form_field > label').eq(3).css('font-size')").should == '16px'
  page.evaluate_script("$('.form_field > label').eq(3).css('font-family')").should == "\"GudeaBold\""
  page.evaluate_script("$('.form_field > label').eq(3).css('color')").should == "rgb(68, 70, 75)"
  check_text("#child_id", "")
end

