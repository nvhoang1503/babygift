#adding mouse hover trigger
module Capybara
  module Node
    class Element
      def hover
        @session.driver.browser.action.move_to(self.native).perform
      end
    end
  end
end

def check_text(element, text)
  with_scope(element) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

#check content & css of a label
def check_label(element, text, size,ffamily,color)
  with_scope(element) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
  page.evaluate_script("$('#{element}').css('font-size')").should == size
  page.evaluate_script("$('#{element}').css('font-family')").should == ffamily
  page.evaluate_script("$('#{element}').css('color')").should == color
end

#steps to click on My Account on right-top corner to go to My Account page
When /^clicking on top\-right corner I go to My Account page$/ do
  page.evaluate_script("$('.dropdown-toggle').trigger('mouseover')")
  page.driver.browser.switch_to.alert.dismiss
  find(".dropdown-menu .my_acc").click
  sleep 4
end

#welcome sentence
Then /^I should see the welcome sentence at the top\-left page$/ do
  page.should have_css("#welcome")
  with_scope("#welcome") do
    if page.respond_to? :should
      page.should have_content("Welcome back, test@littlesparks.com!")
    else
      assert page.has_content?("Welcome back, test@littlesparks.com!")
    end
  end
  page.evaluate_script("$('#welcome').css('font-size')").should == "24px"
  page.evaluate_script("$('#welcome').css('font-family')").should == "'GudeaBold'"
  page.evaluate_script("$('#welcome').css('color')").should == "rgb(68, 70, 75)"
end

#left menu
Then /^I should see links in the left menu$/ do
  page.should have_css("#account_sum a")
  with_scope("#account_sum a") do
    if page.respond_to? :should
      page.should have_content(I18n.t("content.page.account_sum.step"))
    else
      assert page.has_content?(I18n.t("content.page.account_sum.step"))
    end
  end
  page.evaluate_script("$('#account_sum a').css('font-size')").should == "18px"
  page.evaluate_script("$('#account_sum a').css('font-family')").should == "'GudeaBold'"
  page.evaluate_script("$('#account_sum a').css('color')").should == "rgb(68, 70, 75)"
  ["account_contact", "account_child_plan","account_order_his"].each do |el|
    element = "#" + el + " a"
    page.should have_css(element)
    with_scope(element) do
    if page.respond_to? :should
      page.should have_content(I18n.t("content.page.#{el}.step"))
    else
      assert page.has_content?(I18n.t("content.page.#{el}.step"))
    end
  end
    page.evaluate_script("$('#{element}').css('font-size')").should == "18px"
    page.evaluate_script("$('#{element}').css('font-family')").should == "'Gudea'"
    page.evaluate_script("$('#{element}').css('color')").should == "rgb(68, 70, 75)"
  end
end

When /^I click "(.*?)" button$/ do |button_text|
  #The case for a hyperlink
  find('a', :text => button_text).click
  #The case for input
  #...
end

When /^I should see edit link next to Children and Plan text$/ do
  check_text("#child-n-plan a", I18n.t("label.edit"))
end

When /^clicking on edit link I go to Children and Plan page$/ do
  find("#child-n-plan a").click
end

#Wanna sleep to wait for loading
Then /^I wanna sleep "([^"]*)" seconds$/ do |arg1|
  sleep arg1.to_i
end

Then /^I should see "(.*?)" within "(.*?)" '(\d+)' times$/ do |text, selector, number|
  page.all(selector).size.should == number.to_i
end

Then /^I should see "([^"]*)" in "([^"]*)"$/ do |value, field_id|
#  field = find(:xpath, "//*[@id='#{field_id}'][@class='#{field_class}']")
  field = find(:xpath, "//*[@id='#{field_id}']")
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  field_value.send(:should) == value
end


