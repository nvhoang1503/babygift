
Then /^I wanna sleep "([^"]*)" seconds$/ do |arg1|
  sleep arg1.to_i
end

Then /^I should see "(.*?)" within "(.*?)" '(\d+)' times$/ do |text, selector, number|
  page.all(selector).size.should == number.to_i
end
