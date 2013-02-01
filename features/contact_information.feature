Feature: Contact information
  Background:
    Given an account with email "test@littlesparks.com"

  @javascript
  Scenario: Submit contact information with empty first name & last name & email
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page
    When I fill in "First name" with "" on contact information page
    And I fill in "Last name" with "" on contact information page
    And I fill in "Email" with "" on contact information page
    And I click "JOIN THE FAMILY" on contact information page
    And I wanna sleep "5" seconds
    Then I should see "Can't be blank" near first name, last name, email on contact information page

  @javascript
  Scenario: Submit contact information with only 1 letters for first name & last name
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page
    When I fill in "First name" with "a" on contact information page
    And I fill in "Last name" with "b" on contact information page
    And I fill in "Email" with "test@littlesparks.com" on contact information page
    And I click "JOIN THE FAMILY" on contact information page
    And I wanna sleep "5" seconds
    Then I should see "First name must be at least 2 characters" near first name on contact information page
    And I should see "Last name must be at least 2 characters" near last name on contact information page

  @javascript
  Scenario: Submit contact information with incorrect email format
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page
    When I fill in "First name" with "AAAAA" on contact information page
    And I fill in "Last name" with "BBBBB" on contact information page
    And I fill in "Email" with "111" on contact information page
    And I click "JOIN THE FAMILY" on contact information page
    Then I should see "Invalid email" near email on contact information page


  @javascript
  Scenario: Submit contact information successfully
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page
    When I fill in "First name" with "AAAAA" on contact information page
    And I fill in "Last name" with "BBBBB" on contact information page
    And I fill in "Email" with "good@littlesparks.com" on contact information page
    And I click "JOIN THE FAMILY" on contact information page
    And I wanna sleep "3" seconds
    Then I should see "Information saved" on the alert box of account summary page

  @javascript
  Scenario: Go to change password page from contact information
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page
    When I click "Change Password" on contact information page
    Then I should see "CHANGE PASSWORD" on the title of change password page

  @javascript
  Scenario: Submit change pasword with empty Old Password, New Password, Confirm New Password
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page
    When I click "CHANGE PASSWORD" on change password page
    Then I should see "Can't be blank" near Old Password, New Password

  @javascript
  Scenario: Submit change pasword with Old Password field has less than 6 characters
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page
    When I fill in "Old Password" with "123" on change password page
    And I fill in "New Password" with "123" on change password page
    And I fill in "Confirm New Password" with "123" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Password must be at least 6 characters" near Old Password

  @javascript
  Scenario: Submit change pasword with Old Password field has more than 20 characters
    Given I am logged in with email "test@littlesparks.com"
    And I wanna sleep "3" seconds
    And I am on change password page
    And I wanna sleep "3" seconds
    When I fill in "Old Password" with "0123456789012345678901" on change password page
    And I fill in "New Password" with "0123456789012345678901" on change password page
    And I fill in "Confirm New Password" with "0123456789012345678901" on change password page
    And I click "CHANGE PASSWORD" on change password page
    And I wanna sleep "3" seconds
    Then I should see "Password must be at maximum 20 characters" near Old Password

  @javascript
  Scenario: Submit change pasword with New Password field has less than 6 characters
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "123" on change password page
    And I fill in "Confirm New Password" with "123" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Password must be at least 6 characters" near New Password

  @javascript
  Scenario: Submit change pasword with New Password field has more than 20 characters
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "0123456789012345678901" on change password page
    And I fill in "Confirm New Password" with "0123456789012345678901" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Password must be at maximum 20 characters" near New Password

  @javascript
  Scenario: Submit change pasword with new password does not match
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page
    And I wanna sleep "3" seconds
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "12312345" on change password page
    And I fill in "Confirm New Password" with "12312344" on change password page
    And I click "CHANGE PASSWORD" on change password page
    And I wanna sleep "3" seconds
    Then I should see "Passwords do not match" near Confirm New Password

  @javascript
  Scenario: Submit change pasword successfully
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "1234567" on change password page
    And I fill in "Confirm New Password" with "1234567" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Password updated." on contact information page


