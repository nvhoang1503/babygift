
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^I click 'Gifts' on header$/ do
  find(:xpath, "//*[@id='gifts']/a").click()
  # puts find(:xpath, "//*[@id='gifts']/a")
end


Then /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^I wanna sleep '([^"]*)' seconds$/ do |arg1|
  sleep arg1.to_i
end

Given /^I'm in 'gift_recipient' page$/ do
  visit path_to('gift recipient')
end

