Given /^a user exists with email: "(.*?)", password: "(.*?)"$/ do |email, password|
  u = User.new
  u.email = email
  u.password = password
  u.password_confirmation = password
  u.save
  # FactoryGirl.create(:user, [{email: "#{email}", password: "#{password}"}])
end

