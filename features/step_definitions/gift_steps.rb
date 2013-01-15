Given /^the below gifts exist$/ do |table|
  table.hashes.each do |attrs|
    FactoryGirl.create(:gift, attrs)
  end
end


Given /^the below gifts exist with the baby with first name "([^"]*)"$/ do |first_name, table|
  b = Baby.find_by_first_name(first_name)
  table.hashes.each do |attrs|
    attrs[:baby_id] = b.id
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

Given /^the below babies exist with user "([^"]*)"$/ do |sender, table|
  u = User.find_by_email(sender)
  table.hashes.each do |attrs|
    attrs[:user_id] = u.id
    FactoryGirl.create(:baby, attrs)
  end
end