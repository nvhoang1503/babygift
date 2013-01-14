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

      And the first gift code is "gkaii16284ksksk123"
    Given the below addresses exist
      |first_name|last_name|address_1|address_2|city|state|zip  |phone     |
      |ABC       |ABC     |ABC      |ABC      |ABC |CA   |12345|1234567890|
    Given a user exists with email: "test@littlesparks.com", password: "123123"

  @javascript
  Scenario: Access redeem page
  	Given I go to gift recipient 
  	When I click the element within "#left-section a" 
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
    When I fill in "redeem_gift_code" with "gkaii16284ksksk123"
      And I press the key "content.page.redeem_1.btn_submit_form"
    Then I should see the key "content.page.redeem_2.step" within "#step_2"
      And I should see the text "font-family" in "'GudeaBold'" within "#step_2 a"

  @javascript 
  Scenario: access the your child 1 page with an existed account
    Given I go to your account page with the first gift code "gkaii16284ksksk123"
    When I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
      And I fill in "user[password]" with "123123" within ".login_box"
      And I click the element within ".btn_login"
    Then I should see the key "content.page.redeem_3.step" within "#step_3"
      And I should see the text "font-family" in "'GudeaBold'" within "#step_3 a"

  @javascript 
  @current
  Scenario: access the your child 1 page by sign-up a new account
    Given I go to your account page with the first gift code "gkaii16284ksksk123"
    When  I fill in "user[email]" with "test2@littlesparks.com" within ".register_box"
      And  I fill in "email_register_conform" with "test2@littlesparks.com" within ".register_box"
      And I fill in "user[password]" with "123123" within ".register_box"
      And I fill in "user[password_confirmation]" with "123123" within ".register_box"
      And I click the element within ".btn_register"
    Then I should see the key "content.page.redeem_3.step" within "#step_3"
      And I should see the text "font-family" in "'GudeaBold'" within "#step_3 a"

      And I should see the key "content.page.enroll_1.title" within ".tittle_content"
      And I should see the text "color" in "rgb(47, 180, 149)" within ".tittle_content"
      And I should see the text "font-size" in "26px" within ".tittle_content"
      And I should see the text "font-family" in ""GudeaBold"" within ".tittle_content"

      And I should see the key "content.page.enroll_1.optional" within "#gender .text.font20.italic.common-color"
      And I should see the text "color" in "rgb(68, 70, 75)" within "#gender .text.font20.italic.common-color"
      And I should see the text "font-size" in "20px" within "#gender .text.font20.italic.common-color"
      And I should see the text "font-family" in ""GudeaItalic"" within "#gender .text.font20.italic.common-color"

      And I should see the key "content.page.enroll_1.gender_question" within "#gender .text.font24"
      And I should see the text "color" in "rgb(51, 51, 51)" within "#gender .text.font24"
      And I should see the text "font-size" in "24px" within "#gender .text.font24"
      And I should see the text "font-family" in ""Gudea",serif" within "#gender .text.font24"

      And I should see the key "content.page.enroll_1.optional" within "#birthday .text.font20.italic.common-color"
    When I mouseover to "#gender img" 
    Then I should see the key "content.page.enroll_1.optional" within ".tooltip"
