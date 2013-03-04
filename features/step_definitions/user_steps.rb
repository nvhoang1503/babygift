Given /^a user exists with email: "(.*?)", password: "(.*?)"$/ do |email, password|
  u = User.new
  u.email = email
  u.password = password
  u.password_confirmation = password
  u.save
end

Given /^a admin user exists with email: "(.*?)", password: "(.*?)"$/ do |email, password|
  u = User.new
  u.email = email
  u.password = password
  u.password_confirmation = password
  u.is_admin = true
  u.save
end

When /^I log in with email "(.*?)" and password "(.*?)"$/ do |email, password|
  with_scope(".login_box") do
    fill_in("user[email]", :with => email)
    fill_in("user[password]", :with => "123123")
  end
  find(".btn_login").click
  @current_user = User.find_by_email(email)
end

