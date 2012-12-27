Feature: SendGift
  In order to send a gift
  I don't have to login
  I have to pass 3 steps

  Background:
    Given the below gifts exist
      | shipping_address_id | billing_address_id | recipient_email | sender_email | note | plan_type | price | tax | shipping_fee | total | transaction_code | transaction_date | transaction_status | gift_code |
      |  |  | recipient_1@littlespark.com | sender_1@littlespark.com |  |  |  |  |  |  |  |  |  |  |
      |  |  | recipient_2@littlespark.com | sender_2@littlespark.com |  | 1 |  |  |  |  |  |  |  |  |
      |  |  | recipient_3@littlespark.com | sender_3@littlespark.com |  | 1 | 100 |  |0 |  |  |  |  |  |
      | 1 |1 | recipient_4@littlespark.com | sender_4@littlespark.com | good luck | 1 | 100 | 0 |0  |100  |  |  |  | gkaii16284ksksk |

    Given the below addresses exist
      |first_name|last_name|address_1|address_2|city|state|zip  |phone     |
      |ABC       |ABC     |ABC      |ABC      |ABC |CA   |12345|1234567890|


  Scenario: Access gift page
    Given I go to home page
    When I click the element within "#gifts a"
    Then I should see the element within "#gift-info"

  # NAVIGATION LINK
  # ---- Creating step -----
  @javascript
  Scenario: Go to step 2 when staying in step 1
    Given I go to gift recipient
    When I click the element within "#step_2 a"
    Then I should see the key "message.email_missing" within "#flash-panel"

  @javascript
  Scenario: Go to step 3 when staying in step 1
    Given I go to gift recipient
    When I click the element within "#step_3 a"
    Then I should see the key "message.email_missing" within "#flash-panel"

  @javascript
  Scenario: Go to step 4 when staying in step 1
    Given I go to gift recipient
    When I click the element within "#step_4 a"
    Then I should see the key "message.email_missing" within "#flash-panel"

  @javascript
  Scenario: Go to step 3 when staying in step 2
    Given I go to gift monthly plan with gift of sender "sender_1@littlespark.com"
    When I click the element within "#step_3 a"
    Then I should see the key "message.plan_missing" within "#flash-panel"

  @javascript
  Scenario: Go to step 4 when staying in step 2
    Given I go to gift monthly plan with gift of sender "sender_1@littlespark.com"
    When I click the element within "#step_4 a"
    Then I should see the key "message.plan_missing" within "#flash-panel"

  @javascript
  Scenario: Go to step 4 when staying in step 3
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#step_4 a"
    Then I should see the key "message.billing_missing" within "#flash-panel"

  # NAVIGATION LINK
  # ---- Updating step -----
  Scenario: Go to step 3 when staying in step 4
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I click the element within "#step_3 a"
    Then I should see "ABC" in "gift_billing_address_attributes_first_name"
      And I should see "ABC" in "gift_billing_address_attributes_last_name"
      And I should see "ABC" in "gift_billing_address_attributes_address_1"
      And I should see "ABC" in "gift_billing_address_attributes_city"
      And I should see "CA" in "gift_billing_address_attributes_state"
      And I should see "12345" in "gift_billing_address_attributes_zip"
      And I should see "1234567890" in "gift_billing_address_attributes_phone"

  @javascript
  Scenario: Go to step 2 when staying in step 4
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I click the element within "#step_2 a"
    Then I should see the element within "._1-month.selected"

  @javascript
  Scenario: Go to step 1 when staying in step 4
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I click the element within "#step_1 a"
    Then I should see "recipient_4@littlespark.com" in "gift_recipient_email"
      And I should see "sender_4@littlespark.com" in "gift_sender_email"

  @javascript
  Scenario: Go to step 2 when staying in step 3
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#step_2 a"
    Then I should see the element within "._1-month.selected"

  @javascript
  Scenario: Go to step 1 when staying in step 3
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#step_1 a"
    Then I should see "recipient_2@littlespark.com" in "gift_recipient_email"
      And I should see "sender_2@littlespark.com" in "gift_sender_email"

  @javascript
  Scenario: Go to step 1 when staying in step 2
    Given I go to gift monthly plan with gift of sender "sender_1@littlespark.com"
    When I click the element within "#step_1 a"
    Then I should see the element within "#gift-info"

  # STEP 1: RECIPIENT
  @javascript
  Scenario: Do not fill recipient's email
    Given I go to gift recipient
      And I wanna sleep "5" seconds
    When I click the element within "#gift_recipient_email"
      And I click the element within "#gift_recipient_email_confirm"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Fill wrong format of recipient's email
    Given I go to gift recipient
      And I wanna sleep "5" seconds
    When I fill in "gift[recipient_email]" with "email" within ".form-inputs"
      And I click the element within "#gift_recipient_email_confirm"
    Then I should see the key "message.invalid_email" within "span.error"

  @javascript
  Scenario: Wrong confirm recipient's email
    Given I go to gift recipient
    When I fill in "gift[recipient_email]" with "email@littlespark.com" within ".form-inputs"
      And I fill in "gift[recipient_email_confirm]" with "email1@littlespark.com" within ".form-inputs"
      And I click the element within "#gift_sender_email"
    Then I should see the key "message.not_match" within "span.error"

  Scenario: Submit without filling required fields
    Given I go to gift recipient
    When I press "continue to plans" within ".form-inputs"
    Then I should see "Can't be blank" within "span.error" '2' times

  @javascript
  Scenario: Do not input sender's email
    Given I go to gift recipient
      And I wanna sleep "5" seconds
    When I click the element within "#gift_sender_email"
      And I click the element within "#gift_sender_email_confirm"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Input wrong format of sender's email
    Given I go to gift recipient
      And I wanna sleep "5" seconds
    When I fill in "gift[sender_email]" with "email"
      And I click the element within "#gift_sender_email_confirm"
    Then I should see the key "message.invalid_email" within "span.error"

  @javascript
  Scenario: Wrong confirm sender's email
    Given I go to gift recipient
    When I fill in "gift[sender_email]" with "email@littlespark.com"
      And I fill in "gift[sender_email_confirm]" with "email1@littlespark.com"
      And I click the element within "#gift_note"
    Then I should see the key "message.not_match" within "span.error"

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
  Scenario: Continue to account without choosing a plan
    Given I go to gift monthly plan with gift of sender "sender_1@littlespark.com"
    When I press "continue to account" within "#gift-plan"
    Then I should see the key "message.plan_missing" within "#flash-panel"

  @javascript
  Scenario: Choose a gift option and continue to account successfully
    Given I go to gift monthly plan with gift of sender "sender_1@littlespark.com"
    When I click the element within "._6-month"
      And I press "continue to account" within "#gift-plan"
    Then I should see the element within "#gift-billing"

  # STEP 3: BILLING
  @javascript
  Scenario: Do not input first name
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#gift_billing_address_attributes_first_name"
      And I click the element within "#gift_billing_address_attributes_last_name"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Do not input last name
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#gift_billing_address_attributes_last_name"
      And I click the element within "#gift_billing_address_attributes_first_name"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Do not input address line 1
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#gift_billing_address_attributes_address_1"
      And I click the element within "#gift_billing_address_attributes_last_name"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Do not input city
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#gift_billing_address_attributes_city"
      And I click the element within "#gift_billing_address_attributes_last_name"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Do not select state
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#gift_billing_address_attributes_state"
      And I click the element within "#gift_billing_address_attributes_last_name"
    Then I should see the key "message.not_blank" within "span.error"


  @javascript
  Scenario: Do not input zip
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#gift_billing_address_attributes_zip"
      And I click the element within "#gift_billing_address_attributes_last_name"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Do not input phone
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I click the element within "#gift_billing_address_attributes_phone"
      And I click the element within "#gift_billing_address_attributes_last_name"
    Then I should see the key "message.not_blank" within "span.error"

  Scenario: Submit billing address without filling required fields
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I press "continue to payment" within ".form-action"
    Then I should see "Can't be blank" within "span.error" '7' times

  @javascript
  Scenario: Input wrong format of zip
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I fill in "gift[billing_address_attributes][zip]" with "123"
      And I click the element within "#gift_billing_address_attributes_phone"
    Then I should see the key "message.zip_format" within "span.error"

  @javascript
  Scenario: Input not enought the number of phone
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I fill in "gift[billing_address_attributes][phone]" with "123"
      And I click the element within "#gift_billing_address_attributes_city"
    Then I should see the key "message.phone_invalid" within "span.error"

  @javascript
  Scenario: Input wrong format of phone
    Given I go to gift billing with gift of sender "sender_2@littlespark.com"
    When I fill in "gift[billing_address_attributes][phone]" with "1--23"
      And I click the element within "#gift_billing_address_attributes_city"
    Then I should see the key "message.phone_format" within "span.error"

  Scenario: Submit billing address information successfully
    Given I go to gift billing with gift of sender "sender_3@littlespark.com"
    When I fill in "gift[billing_address_attributes][first_name]" with "first name" within ".form-inputs"
      And I fill in "gift[billing_address_attributes][last_name]" with "last name" within ".form-inputs"
      And I fill in "gift[billing_address_attributes][address_1]" with "abc"
      And I fill in "gift[billing_address_attributes][city]" with "abc"
      And I select "California" from "gift[billing_address_attributes][state]" within ".form-inputs"
      And I fill in "gift[billing_address_attributes][zip]" with "12345"
      And I fill in "gift[billing_address_attributes][phone]" with "1234567890"
      And I press "continue to payment" within ".form-action"
      And I wanna sleep "20" seconds
    Then I should see the element within ".payment-form"

  # STEP 4: PAYMENT
  @javascript
  Scenario: Do not input card number
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I click the element within "#card_number"
      And I click the element within "#card_security"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Do not match the card type
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I click the element within ".icon-credit-card.visa"
      And I fill in "card_number" with "411111111"
      And I click the element within "#card_security"
    Then I should see the key "message.card_format" within "span.error"

  @javascript
  Scenario: Do not choose card type
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I fill in "card_number" with "411111111"
      And I click the element within "#card_security"
    Then I should see the key "message.card_missing" within "span.error"

  @javascript
  Scenario: Select an invalid expiration date
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I select "11" from "date[exp_month]" within "#frm-payment"
    Then I should see the key "message.invalid_expiration" within "span.error"

  @javascript
  Scenario: Do not input security code
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I click the element within "#card_security"
      And I click the element within "#card_number"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript
  Scenario: Submit payment without select 'Terms & Conditions'
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I press "PLACE YOUR ORDER" within "#frm-payment"
    Then I should see the key "message.term_missing" within "#flash-panel"

  Scenario: Submit payment successfully
    Given I go to gift payment with gift of sender "sender_4@littlespark.com"
    When I click the element within ".icon-credit-card.visa"
      And I fill in "card_number" with "4111111111111111"
      And I select "12" from "date[exp_month]" within "#frm-payment"
      And I select "2013" from "date[exp_year]" within "#frm-payment"
      And I fill in "card_security" with "123"
      And I check "terms_agreement"
      And I press "PLACE YOUR ORDER" within "#frm-payment"
    Then I should see "Congratulations!"

