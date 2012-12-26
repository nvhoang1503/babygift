
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
