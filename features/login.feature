Feature: Login

  Background:
    Given a user exists with email: "test@littlesparks.com", password: "123123"
  @javascript
  Scenario: Sign in
    Given I go to the login page
    When  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I wanna sleep "2" seconds
    Then I should see the key "devise.sessions.signed_in" within "#flash-panel"

  @javascript
  Scenario: Sign in with empty fields
    Given I go to the login page
    And I click the element within ".btn_login"
    And I wanna sleep "2" seconds
    Then I should see "Can't be blank" within "#email_login_error"
    Then I should see "Can't be blank" within "#passwork_login_error"

  @javascript
  Scenario: Sign in with invalid email
    Given I go to the login page
    When  I fill in "user[email]" with "!" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "~" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "#" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "$" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "%" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "^" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "&" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "*" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "(" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with ")" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "_" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "+" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with '"' within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with ":" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "'" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "?" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with "<" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"
    When  I fill in "user[email]" with ">" within ".login_box"
    Then I should see "Invalid email" within "#email_login_error"


  @javascript
  Scenario: Sign out
    Given I go to the login page
    When  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I click the element within ".btn_top_login"
    And I wanna sleep "20" seconds
    Then I should see "Log in" within ".btn_top_login"

  @javascript
  Scenario: Sign up (Join the family)
    Given I go to the login page
    When  I fill in "user[email]" with "test2@littlesparks.com" within ".register_box"
    And  I fill in "email_register_conform" with "test2@littlesparks.com" within ".register_box"
    And I fill in "user[password]" with "123123" within ".register_box"
    And I fill in "user[password_confirmation]" with "123123" within ".register_box"

    And I click the element within ".btn_register"
    And I wanna sleep "2" seconds
    Then I should see the key "content.page.login.sign_up_successfully" within "#flash-panel"

  @javascript
  Scenario: Sign up (Join the family) with 3 length password
    Given I go to the login page
    When  I fill in "user[email]" with "test2@littlesparks.com" within ".register_box"
    And  I fill in "email_register_conform" with "test2@littlesparks.com" within ".register_box"
    And I fill in "user[password]" with "123" within ".register_box"
    And I fill in "user[password_confirmation]" with "123" within ".register_box"

    And I click the element within ".btn_register"
    And I wanna sleep "2" seconds
    Then I should see "Password must be at least 6 characters" within ".register_box .error"

  @javascript
  Scenario: Sign up (Join the family) with existing email address
    Given I go to the login page
    When  I fill in "user[email]" with "test@littlesparks.com" within ".register_box"
    And I fill in "email_register_conform" with "test@littlesparks.com" within ".register_box"
    And I fill in "user[password]" with "123123" within ".register_box"
    And I fill in "user[password_confirmation]" with "123123" within ".register_box"

    And I click the element within ".btn_register"
    And I wanna sleep "2" seconds
    Then I should see "An account with this email already exists" within ".register_box .error"

  @javascript
  Scenario: Forgot password with valid email
    Given I go to the login page
    When I follow the key "content.page.login.forgot_pass"
    And I fill in "user[email]" with "test@littlesparks.com" within ".forgot_box"
    And I click the element within ".btn_forgot"
    Then I should see "An email has been sent to your email to reset your password." within "#flash-panel"
    When I visited "test@littlesparks.com" mail a link to reset your password
    And I wanna sleep "3" seconds
    And I fill in "user[password]" with "123123" within ".change_box"
    And I fill in "user[password_confirmation]" with "123123" within ".change_box"
    And I click the element within ".btn_change_pass"
    Then I should see "Your password was changed successfully. You are now signed in." within "#flash-panel"

  @javascript
  Scenario: Forgot password with invalid email
    Given I go to the login page
    When I follow the key "content.page.login.forgot_pass"
    And I fill in "user[email]" with "test_not_found@littlesparks.com" within ".forgot_box"
    And I click the element within ".btn_forgot"
    Then I should see "Not found" within ".forgot_box .error"

  @javascript
  Scenario: Forgot password with invalid token
    Given I go to the login page
    When I follow the key "content.page.login.forgot_pass"
    And I fill in "user[email]" with "test@littlesparks.com" within ".forgot_box"
    And I click the element within ".btn_forgot"
    Then I should see "An email has been sent to your email to reset your password." within "#flash-panel"
    When I visited a link to reset your password with token "12345678"
    And I wanna sleep "3" seconds
    And I fill in "user[password]" with "123123" within ".change_box"
    And I fill in "user[password_confirmation]" with "123123" within ".change_box"
    And I click the element within ".btn_change_pass"
    Then I should see "Reset password token is invalid" within ".change_box .error.full_error"