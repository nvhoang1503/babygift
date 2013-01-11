Feature: Redeem the gift
  In order to buy a gift for my child
  As a nomal user(logged in or not)
  I want to redeem a gift through 5 steps 

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

  @javascript
  Scenario: Access redeem page
  	Given I go to gift recipient 
  	When I click the element within "#left-section a" 
      And I wanna sleep "5" seconds
  	Then I should see the key "content.page.redeem_1.step" within "#step_1"
  	  And I should see the key "content.page.redeem_2.step" within "#step_2"
  	  And I should see the key "content.page.redeem_3.step" within "#step_3"
  	  And I should see the key "content.page.redeem_4.step" within "#step_4"
  	  And I should see the key "content.page.redeem_finish.step" within "#step_5"

  	  And I should see the key "content.page.redeem_1.title" within ".tittle_content.redeem_title"
  	  And I should see the text "color" in "rgb(47, 180, 149)" within ".tittle_content.redeem_title"
  	  And I should see the text "font-size" in "26px" within ".tittle_content.redeem_title"
  	  And I should see the text "font-family" in ""GudeaBold"" within ".tittle_content.redeem_title"

      And I should see the key "content.page.redeem_1.desc" within ".description"
      And I should see the text "color" in "rgb(68, 70, 75)" within ".description"
      And I should see the text "font-size" in "18px" within ".description"
      And I should see the text "font-family" in "'Gudea'" within ".description"

      And I should see the key "content.page.redeem_1.fill_code" within ".font24.common-color"
      And I should see the text "color" in "rgb(68, 70, 75)" within ".font24.common-color"
      And I should see the text "font-size" in "24px" within ".font24.common-color"
      And I should see the text "font-family" in ""Gudea",serif" within ".font24.common-color"

      And I should see "" within "#redeem_gift_code"
      And I should see button with the key "content.page.redeem_1.btn_submit_form"

  @javascript 
  Scenario: submit step 1 without input gift code 
    Given I go to gift redeem page
    When I press the key "content.page.redeem_1.btn_submit_form"
    Then I should see the key "message.not_blank" within "span.error"

  @javascript 
  Scenario: submit step 1 with an invalid code 
    Given I go to gift redeem page
    When I fill in "redeem_gift_code" with "abc"
      And I press the key "content.page.redeem_1.btn_submit_form"
    Then I should see the key "message.gift_code_incorrect" within "span.error"

  @javascript 
  Scenario: submit step 1 with a valid code 
    Given I go to gift redeem page
    When I fill in "redeem_gift_code" with the first gift code
      And I press the key "content.page.redeem_1.btn_submit_form"
      And I wanna sleep "10" seconds
    Then I should see the key "content.page.redeem_2.step" within "#step_2"
      And I should see the text "font-family" in "'GudeaBold'" within "#step_2 a"
