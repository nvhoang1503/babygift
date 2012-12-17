Feature: SendGift
  In order to send a gift
  I don't have to login
  I have to pass 3 steps

  Scenario: Access gift page
    Given I go to home page
    When I click 'Gifts' on header
    Then I go to kits page
  @current
  @javascript
  Scenario: Do not fill recipient's email
    Given I go to gift recipient
    When I focus on 'recipient_email'
      And leave input field
    Then I should see error message "Can't be blank"

  Scenario: Fill wrong format of recipient's email
    Given I go to the gift recipient page
    When I focus on 'recipient_email'
      And I fill 'email' to 'recipient_email' field
      And leave input field
    Then I should see error message "Invalid email"

  Scenario: Wrong confirm recipient's email
    Given I go to the gift recipient page
    When I fill 'user@gmail.com' to 'recipient_email' field
      And I fill 'user1@gmail.com' to 'recipient_email_confirm' field
      And leave input field
    Then I should see error message "Doesn't match confirmation"

  Scenario: Submit without filling required fields
    Given Igo to the gift recipient page
    When I click on continue button
    Then I should see error message "Can't be blank" bellow 'recipient_email' and 'sender_email' fields

  Scenario: Do not input sender's email
    Given I' go to the gift recipient page
    When I focus on 'sender_email'
      And leave input field
    Then I should see error message "Can't be blank"

  Scenario: Input wrong format of sender's email
    Given I go to the gift recipient page
    When I focus on 'sender_email'
      And I fill 'email' to 'sender_email' field
      And leave input field
    Then I should see error message "Invalid email"

  Scenario: Wrong confirm sender's email
    Given I go to the gift recipient page
    When I fill 'sender@gmail.com' to 'sender_email' field
      And I fill 'sender1@gmail.com' to 'sender_email_confirm' field
      And leave input field
    Then I should see error message "Doesn't match confirmation"

  Scenario: submit basic information
    Given I go to the gift recipient page
    When I fill 'recipient@gmail.com' to 'recipient_email' field
      And I fill 'recipient@gmail.com' to 'recipient_confirm_email' field
      And I fill 'sender@gmail.com' to 'sender_email' field
      And I fill 'sender@gmail.com' to 'sender_confirm_email' field
      And I fill 'Good luck to you!' to 'gift_message' field
      And I click on 'continue' button
    Then I should go to 'gift monthly_plan' page
