Feature: SendGift
  In order to send a gift
  I don't have to login
  I have to pass 3 steps

  Scenario: Access gift page
    Given I go to home page
    When I click the element within "#gifts a"
    Then I should see the element within "#gift-info"

  # NAVIGATION LINK
  # ---- Creating step -----
  #to do
  Scenario: Go to step 2 when staying in step 1
    Given I go to gift recipient
    When I click the element within "#step_2 a"
    Then I should see "Please input emails first" within "#flash-panel"

  #to do
  Scenario: Go to step 3 when staying in step 1
    Given I go to gift recipient
    When I click the element within "#step_3 a"
    Then I should see "Please input emails first" within "#flash-panel"

  #to do
  Scenario: Go to step 4 when staying in step 1
    Given I go to gift recipient
    When I click the element within "#step_4 a"
    Then I should see "Please input emails first" within "#flash-panel"

  #to do
  Scenario: Go to step 3 when staying in step 2
    Given I go to gift monthly plan
    When I click the element within "#step_3 a"
    Then I should see "Please choose your gift option first" within "#flash-panel"

  #todo
  Scenario: Go to step 4 when staying in step 2
    Given I go to gift monthly plan
    When I click the element within "#step_4 a"
    Then I should see "Please choose your gift option first" within "#flash-panel"

  #todo
  Scenario: Go to step 4 when staying in step 3
    Given I go to gift billing
    When I click the element within "#step_4 a"
    Then I should see "Please input your billing information first" within "#flash-panel"

  # NAVIGATION LINK
  # ---- Updating step -----
  #todo
  Scenario: Go to step 3 when staying in step 4
    Given I go to gift payment
    When I click the element within "#step_3 a"
    Then I should see the element within "#gift-billing"

  #todo
  Scenario: Go to step 2 when staying in step 4
    Given I go to gift payment
    When I click the element within "#step_2 a"
    Then I should see the element within "#gift-plan"

  #todo
  Scenario: Go to step 1 when staying in step 4
    Given I go to gift payment
    When I click the element within "#step_1 a"
    Then I should see the element within "#gift-info"

  #todo
  Scenario: Go to step 2 when staying in step 3
    Given I go to gift billing
    When I click the element within "#step_2 a"
    Then I should see the element within "#gift-plan"

  #todo
  Scenario: Go to step 1 when staying in step 3
    Given I go to gift billing
    When I click the element within "#step_1 a"
    Then I should see the element within "#gift-info"

  #todo
  Scenario: Go to step 1 when staying in step 2
    Given I go to gift monthly plan
    When I click the element within "#step_1 a"
    Then I should see the element within "#gift-info"

  # STEP 1: RECIPIENT
  #to do
  Scenario: Do not fill recipient's email
    Given I go to gift recipient
    When I click the element within "#gift_recipient_email"
      And I wanna sleep "2" seconds
      And I click the element within "#gift_recipient_email_confirm"
    Then I should see "Can't be blank" within "span.error"

  #to do
  Scenario: Fill wrong format of recipient's email
    Given I go to gift recipient
    When I fill in "gift[recipient_email]" with "email" within ".form-inputs"
      And I click the element within "#gift_recipient_email_confirm"
    Then I should see "Invalid email" within "span.error"

  #to do
  Scenario: Wrong confirm recipient's email
    Given I go to gift recipient
    When I fill in "gift[recipient_email]" with "email@littlespark.com" within ".form-inputs"
      And I fill in "gift[recipient_email_confirm]" with "email1@littlespark.com" within ".form-inputs"
      And I click the element within "#gift_sender_email"
    Then I should see "Doesn't match confirmation" within "span.error"

  # todo
  Scenario: Submit without filling required fields
    Given I go to gift recipient
    When I press "continue to plans" within ".form-inputs"
    Then I should see "Can't be blank" within "span.error" '4' times

  #to do
  Scenario: Do not input sender's email
    Given I go to gift recipient
    When I click the element within "#gift_sender_email"
      And I wanna sleep "2" seconds
      And I click the element within "#gift_sender_email_confirm"
    Then I should see "Can't be blank" within "span.error"

  #todo
  Scenario: Input wrong format of sender's email
    Given I go to gift recipient
    When I fill in "gift[sender_email]" with "email"
      And I click the element within "#gift_sender_email_confirm"
    Then I should see "Invalid email" within "span.error"

  #to do
  Scenario: Wrong confirm sender's email
    Given I go to gift recipient
    When I fill in "gift[sender_email]" with "email@littlespark.com"
      And I fill in "gift[sender_email_confirm]" with "email1@littlespark.com"
      And I click the element within "#gift_note"
    Then I should see "Doesn't match confirmation" within "span.error"

  #to do
  Scenario: Submit basic information successfully
    Given I go to gift recipient
    When I fill in "gift[recipient_email]" with "email@littlespark.com" within ".form-inputs"
      And I fill in "gift[recipient_email_confirm]" with "email@littlespark.com" within ".form-inputs"
      And I fill in "gift[sender_email]" with "email@littlespark.com"
      And I fill in "gift[sender_email_confirm]" with "email@littlespark.com"
      And I fill in "gift[note]" with "Good luck"
      And I press "continue to plans" within ".form-inputs"
    Then I should see the element within "#gift-plan"

  # STEP 2: MONTHLY PLAN
  # todo
  Scenario: Continue to account without choosing a plan
    Given I go to gift monthly plan
    When I press "continue to account" within "#gift-plan"
    Then I should see "Choose your gift option" within "#flash-panel"

  # todo
  Scenario: Choose a gift option and continue to account successfully
    Given I go to gift monthly plan
    When I click the element within "._6-month"
      And I press "continue to account" within "#gift-plan"
    Then I should see the element within "#gift-billing"


  # STEP 3: BILLING
