Given /^the below gifts exists$/ do |table|
  table.hashes.each do |attrs|
    FactoryGirl.create(:gift, attrs)
  end
end

Given /^I have a gift with "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

# Given /^I have gif "([^"]*)" the "([^"]*)"$/ do |action, menu|
#   user = model("me")
#   attrs = {:name => menu}
#   actions = action.split(",")
#   actions.each { |a| attrs[:"#{a}"] = true }
#   user.role.permissions.create!(attrs)
# end
