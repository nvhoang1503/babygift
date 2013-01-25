Given /^I have some orders$/ do |table|
  table.hashes.each do |attrs|
    baby_id = Baby.find_by_first_name(attrs[:baby].split(" ").first).id
    FactoryGirl.create(:order, {:baby_id => baby_id, :plan_type => attrs[:plan_type], :price => attrs[:price]})
  end
end
