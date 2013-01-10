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
  Scenario: Sign up (Join the family)
    Given I go to the login page
    When  I fill in "user[email]" with "test2@littlesparks.com" within ".register_box"
    And  I fill in "email_register_conform" with "test2@littlesparks.com" within ".register_box"
    And I fill in "user[password]" with "123123" within ".register_box"
    And I fill in "user[password_confirmation]" with "123123" within ".register_box"

    And I click the element within ".btn_register"
    And I wanna sleep "2" seconds
    Then I should see the key "content.page.login.sign_up_successfully" within "#flash-panel"