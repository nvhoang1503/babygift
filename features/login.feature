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