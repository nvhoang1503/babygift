Feature: Contact information
  Background:
    Given an account with email "test@littlesparks.com"

  @javascript
  Scenario: Submit contact information with empty first name & last name & email
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page of the account has email "test@littlesparks.com"
    When I fill in "First name" with "" on contact information page
    And I fill in "Last name" with "" on contact information page
    And I fill in "Email" with "" on contact information page
    And I click "JOIN THE FAMILY" on contact information page
    And I wanna sleep "5" seconds
    Then I should see "Can't be blank" near first name, last name, email on contact information page

  @javascript
  Scenario: Submit contact information with incorrect email format
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page of the account has email "test@littlesparks.com"
    When I fill in "First name" with "AAAAA" on contact information page
    And I fill in "Last name" with "BBBBB" on contact information page
    And I fill in "Email" with "111" on contact information page
    And I click "JOIN THE FAMILY" on contact information page
    Then I should see "Invalid email" near email on contact information page


  @javascript
  Scenario: Submit contact information successfully
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page of the account has email "test@littlesparks.com"
    When I fill in "First name" with "AAAAA" on contact information page
    And I fill in "Last name" with "BBBBB" on contact information page
    And I fill in "Email" with "good@littlesparks.com" on contact information page
    And I click "JOIN THE FAMILY" on contact information page
    And I wanna sleep "5" seconds
    Then I should see "Save successfully" on account summary page

  @javascript
  Scenario: Go to change password page from contact information
    Given I am logged in with email "test@littlesparks.com"
    And I am on contact information page of the account has email "test@littlesparks.com"
    When I click "Change Password" on contact information page
    Then I should see "CHANGE PASSWORD" on the title of change password page

  @javascript
  Scenario: Submit change pasword with empty Old Password, New Password, Confirm New Password
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page of the account has email "test@littlesparks.com"
    When I click "CHANGE PASSWORD" on change password page
    Then I should see "Can't be blank" near Old Password, New Password, Confirm New Password


  @javascript
  Scenario: Submit change pasword with New Password field has less than 6 characters
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page of the account has email "test@littlesparks.com"
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "123" on change password page
    And I fill in "Confirm New Password" with "123" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Password must be at least 6 characters" near New Password and Confirm New Password

  @javascript
  Scenario: Submit change pasword with New Password field has more than 20 characters
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page of the account has email "test@littlesparks.com"
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "0123456789012345678901" on change password page
    And I fill in "Confirm New Password" with "0123456789012345678901" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Password must be at maximum 20 characters" near New Password and Confirm New Password

  @javascript
  Scenario: Submit change pasword with new password does not match
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page of the account has email "test@littlesparks.com"
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "123" on change password page
    And I fill in "Confirm New Password" with "345" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Passwords do not match" near New Password and Confirm New Password

  @javascript
  Scenario: Submit change pasword successfully
    Given I am logged in with email "test@littlesparks.com"
    And I am on change password page of the account has email "test@littlesparks.com"
    When I fill in "Old Password" with "123123" on change password page
    And I fill in "New Password" with "1234567" on change password page
    And I fill in "Confirm New Password" with "1234567" on change password page
    And I click "CHANGE PASSWORD" on change password page
    Then I should see "Password has changed successfully" on account summary page


