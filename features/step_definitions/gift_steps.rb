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
