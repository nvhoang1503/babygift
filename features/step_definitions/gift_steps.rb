Given /^the below gifts exist$/ do |table|
  table.hashes.each do |attrs|
    FactoryGirl.create(:gift, attrs)
  end
end

Given /^the below addresses exist$/ do |table|
  table.hashes.each do |attrs|
    FactoryGirl.create(:address, attrs)
  end
end

Given /^the first gift code is "(.*?)"$/ do |gift_code|
  gift = Gift.first
  gift.update_attributes({:gift_code => gift_code})
end

Given /^the below babies exist$/ do |table|
  table.hashes.each do |attrs|
    FactoryGirl.create(:baby, attrs)
  end
end