Given /^an account with email "(.*?)"$/ do |email|
  u = User.new
  u.email = email
  u.first_name = "AAA"
  u.last_name = "BBB"
  u.password = "123123"
  u.password_confirmation = "123123"
  u.save
end

Given /^I am logged in with email "(.*?)"$/ do |email|
  visit path_to("login page")
  with_scope(".login_box") do
    fill_in("user[email]", :with => email)
    fill_in("user[password]", :with => "123123")
  end
  find(".btn_login").click
end

When /^I fill in "First name" with "(.*?)" on contact information page$/ do |value|
  with_scope(".contact_information") do
    fill_in("user[first_name]", :with => value)
  end
end

When /^I fill in "Last name" with "(.*?)" on contact information page$/ do |value|
  with_scope(".contact_information") do
    fill_in("user[last_name]", :with => value)
  end
end

When /^I fill in "Email" with "(.*?)" on contact information page$/ do |value|
  with_scope(".contact_information") do
    fill_in("user[email]", :with => value)
  end
end



When /^I click "JOIN THE FAMILY" on contact information page$/ do
  find(".btn_contact_info").click
end


When /^I click "Change Password" on contact information page$/ do
  find(".btn_pass_change").click
end

Then /^I should see "(.*?)" near first name, last name, email on contact information page$/ do |error_message|
  with_scope(".first_name_field") do
    if page.respond_to? :should
      page.should have_content(error_message)
    else
      assert page.has_content?(error_message)
    end
  end

  with_scope(".last_name_field") do
    if page.respond_to? :should
      page.should have_content(error_message)
    else
      assert page.has_content?(error_message)
    end
  end

  with_scope(".email_field") do
    if page.respond_to? :should
      page.should have_content(error_message)
    else
      assert page.has_content?(error_message)
    end
  end
end

Then /^I should see "(.*?)" near email on contact information page$/ do |error_message|
  with_scope(".email_field") do
    if page.respond_to? :should
      page.should have_content(error_message)
    else
      assert page.has_content?(error_message)
    end
  end
end

Then /^I should see "(.*?)" on the title of change password page$/ do |title|
  with_scope(".tittle_box") do
    if page.respond_to? :should
      page.should have_content(title)
    else
      assert page.has_content?(title)
    end
  end
end


When /^I click "CHANGE PASSWORD" on change password page$/ do
  find(".btn_change_password").click
end

Then /^I should see "(.*?)" near Old Password, New Password, Confirm New Password$/ do |error_message|
  with_scope(".old_password_field") do
    if page.respond_to? :should
      page.should have_content(error_message)
    else
      assert page.has_content?(error_message)
    end
  end

  with_scope(".new_password_field") do
    if page.respond_to? :should
      page.should have_content(error_message)
    else
      assert page.has_content?(error_message)
    end
  end

  with_scope(".cf_new_password_field") do
    if page.respond_to? :should
      page.should have_content(error_message)
    else
      assert page.has_content?(error_message)
    end
  end
end