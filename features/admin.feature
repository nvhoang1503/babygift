Feature: Admin
  In order to download report
  As an admin user

  Background:
    Given a user exists with email: "user@littlespark.com", password: "123123"
      And a admin user exists with email: "admin@littlespark.com", password: "123123"

  # ACCESS AS NORMAL USER
  Scenario: access admin page as a admin user
    Given I go to admin login
    When I fill in "user[email]" with "admin@littlespark.com" within ".login_box"
      And I fill in "user[password]" with "123123" within ".login_box"
      And I press "Sign in" within "#new_user"
    Then I should see "Signed in successfully." within "#flash-panel"

  Scenario: access admin page as a normal user
    Given I go to admin login
    When I fill in "user[email]" with "user@littlespark.com" within ".login_box"
      And I fill in "user[password]" with "123123" within ".login_box"
      And I press "Sign in" within "#new_user"
    Then I should see the key "message.admin_invalid" within "span#exsting_email"

  Scenario: access admin page with wrong username/password
    Given I go to admin login
    When I fill in "user[email]" with "user@littlespark.com" within ".login_box"
      And I fill in "user[password]" with "1231231" within ".login_box"
      And I press "Sign in" within "#new_user"
    Then I should see the key "message.email_pass_invalid" within "span#exsting_email"

  @javascript
  Scenario: access admin page by normal user already login
  Given I go to login page
    When I fill in "user[email]" with "user@littlespark.com" within ".login_box"
      And I fill in "user[password]" with "123123" within ".login_box"
      And I press "Sign in" within ".login_box"
      And I go to admin login
      Then I should see the key "message.admin_permission_denied" within "#flash-panel"
