Feature: Redeem the gift
  In order to buy a gift for my child
  As a nomal user(logged in or not)
  I want to redeem a gift through 5 steps

  Background:
    Given a user exists with email: "test@littlesparks.com", password: "123123"

    Given a user exists with email: "test_no_child@littlesparks.com", password: "123123"

    Given the below babies exist with user "test@littlesparks.com"
      |first_name|last_name|birthday   |gender|
      |A         |B        |01/01/1999 |-1    |

    Given the below gifts exist
      | shipping_address_id | billing_address_id | recipient_email | sender_email | note | plan_type | baby_id | price | tax | shipping_fee | total | transaction_code | transaction_date | transaction_status | gift_code |
      |  |  | recipient_1@littlespark.com | sender_1@littlespark.com |  |  |  |  |  |  |  |  |  |  |  |
      |  |  | recipient_2@littlespark.com | sender_2@littlespark.com |  | 1 |1 |  |  |  |  |  |  |  |  |
      |  |  | recipient_3@littlespark.com | sender_3@littlespark.com |  | 1 |1 | 100 |  |0 |  |  |  |  |  |
      | 1 |1 | recipient_4@littlespark.com | sender_4@littlespark.com | good luck | 1 |1 | 100 | 0 |0  |100  |  |  |  | gkaii16284ksksk |

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
  Scenario: submit step 1 with a valid code (not logged in)
    Given I go to gift redeem page
    When I fill in "redeem_gift_code" with the first gift code
      And I press the key "content.page.redeem_1.btn_submit_form"
      And I wanna sleep "10" seconds
    Then I should see the key "content.page.redeem_2.step" within "#step_2"
      And I should see the text "font-family" in "'GudeaBold'" within "#step_2 a"

  @javascript
  Scenario: submit step 1 with a valid code (logged in)
    Given I go to the login page
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I go to gift redeem page
    When I fill in "redeem_gift_code" with the first gift code
      And I press the key "content.page.redeem_1.btn_submit_form"
      And I wanna sleep "10" seconds
    Then I should see the key "content.page.redeem_2.step" within "#step_2"
      And I should see the text "font-family" in "'GudeaBold'" within "#step_3 a"

  @javascript
  Scenario: Go to step 4 when staying in step 3 (Adding a new child) with blank input values (logged in)
    Given I go to the login page
    And  I fill in "user[email]" with "test_no_child@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I go to gift redeem your child page with the redeem of sender "sender_1@littlespark.com"
    And I wanna sleep "5" seconds
    When I click the element within "#step_4 a"
    Then I should see the key "message.not_blank" within "#wrapfirstnamejqiho span.error"
    And I should see the key "message.not_blank" within "#wraplastnamejqiho span.error"
    And I should see the key "message.selection_missing" within ".error.gender_error"

  @javascript
  Scenario: Go to step 5 when staying in step 4 with blank input values (logged in)
    Given the below babies exist
      |first_name|last_name|birthday   |gender|user_id|
      |A         |B        |01/01/1999 |-1    |1      |
    And I go to the login page
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I go to gift redeem Shipping page with the redeem of sender "sender_1@littlespark.com"
    When I click the element within "#step_5 a"
    And I wanna sleep "5" seconds
    Then I should see the key "message.not_blank" within ".first_name"
    And I should see the key "message.not_blank" within ".last_name"
    And I should see the key "message.not_blank" within ".address_1"
    And I should see the key "message.not_blank" within ".city"
    And I should see the key "message.not_blank" within ".state"
    And I should see the key "message.not_blank" within "div.zip"
    And I should see the key "message.not_blank" within ".phone"



  @javascript
  Scenario: Place the order when staying in step 5 with blank checkbox values (logged in)
    Given I go to the login page
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I go to gift redeem Payment page with the redeem of sender "sender_4@littlespark.com"
    When I click the element within ".btn-place"
    And I should see the key "message.term_missing" within ".error.term_error"
    And I wanna sleep "5" seconds

  @javascript
  Scenario: Place the order when staying in step 5 with checking "I agree with the Terms and Conditions" (logged in)
    Given I go to the login page
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I go to gift redeem Payment page with the redeem of sender "sender_4@littlespark.com"
    When I click the element within "#cb_terms"
    And I wanna sleep "5" seconds
    And I click the element within ".btn-place"
    And I wanna sleep "5" seconds
    And I should see the key "content.page.congrate.title" within ".congrate_finish_content"


# STEP 3: Shipping

  @javascript
  Scenario: Go to step 5 when staying in step 4 with wrong format of zip (logged in)
    Given the below babies exist
      |first_name|last_name|birthday   |gender|user_id|
      |A         |B        |01/01/1999 |-1    |1      |
    And I go to the login page
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I wanna sleep "3" seconds
    And I go to gift redeem your updating child page with the redeem of sender "sender_1@littlespark.com"
    And I wanna sleep "3" seconds
    When I click the element within "#step_4 a"
    And I wanna sleep "3" seconds
    When I fill in "redeem[shipping_address_attributes][zip]" with "123"
    And I click the element within "#redeem_shipping_address_attributes_phone"
    And I wanna sleep "2" seconds
    Then I should see the key "message.zip_format" within ".zip span.error"

  @javascript
  Scenario: Go to step 5 when staying in step 4 with wrong format of phone (logged in)
    Given the below babies exist
      |first_name|last_name|birthday   |gender|user_id|
      |A         |B        |01/01/1999 |-1    |1      |
    And I go to the login page
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I wanna sleep "3" seconds
    And I go to gift redeem Shipping page with the redeem of sender "sender_1@littlespark.com"
    And I wanna sleep "3" seconds
    When I fill in "redeem[shipping_address_attributes][phone]" with "123"
    And I click the element within "#redeem_shipping_address_attributes_city"
    And I wanna sleep "3" seconds
    Then I should see the key "message.phone_invalid" within ".phone span.error"

  @javascript
  Scenario: Submit to step 5 when staying in step 4 successfully (logged in)
    Given the below babies exist
      |first_name|last_name|birthday   |gender|user_id|
      |A         |B        |01/01/1999 |-1    |1      |
    And I go to the login page
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I wanna sleep "3" seconds
    And I go to gift redeem Shipping page with the redeem of sender "sender_4@littlespark.com"
    And I wanna sleep "3" seconds
    When I fill in "redeem[shipping_address_attributes][first_name]" with "first name" within ".form-inputs"
    And I fill in "redeem[shipping_address_attributes][last_name]" with "last name" within ".form-inputs"
    And I fill in "redeem[shipping_address_attributes][address_1]" with "abc"
    And I fill in "redeem[shipping_address_attributes][city]" with "abc"
    And I select "California" from "redeem[shipping_address_attributes][state]" within ".form-inputs"
    And I fill in "redeem[shipping_address_attributes][zip]" with "12345"
    And I fill in "redeem[shipping_address_attributes][phone]" with "1234567890"
    And I wanna sleep "5" seconds
    And I click the element within ".shipping_continue .next"
    And I wanna sleep "5" seconds
    Then I should see the text "font-family" in "'GudeaBold'" within "#step_5 a"

# STEP Congratulations
  @javascript
  Scenario: Place the order when staying in step 5 with checking "I agree with the Terms and Conditions" (logged in)
    Given I go to the login page
    And I wanna sleep "3" seconds
    And  I fill in "user[email]" with "test@littlesparks.com" within ".login_box"
    And I fill in "user[password]" with "123123" within ".login_box"
    And I click the element within ".btn_login"
    And I wanna sleep "3" seconds
    And I go to gift redeem Payment page with the redeem of sender "sender_4@littlespark.com"
    And I wanna sleep "3" seconds
    When I click the element within "#cb_terms"
    And I click the element within ".btn-place"
    And I wanna sleep "2" seconds
    And I should see the key "content.page.congrate.title" within ".congrate_finish_content"
    And I should see the text "color" in "rgb(81, 82, 87)" within ".title_page"
    And I should see the text "font-size" in "34px" within ".title_page"
    And I should see the text "font-family" in ""GudeaBold"" within ".title_page"