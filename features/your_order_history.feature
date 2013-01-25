Feature: Your Order History
  Background:
    Given an account with email "test@littlesparks.com"
    And the order history with the following information exist:
    | ORDER      | DATE        | RECIPIENT    | CHILD     | PLAN         |
    | 2183005924 | 01/21/2013  | Mickey Mouse | Peter Pan | 3-Months Kit |
    And the shipping information exist with the order history:
    | FULL_NAME  | ADDRESS     | CITY_STATE   |
    |Mickey Mouse| 10 WW       | San,AK 11111 |
    And the payment information exist with the order history:
    | FULL_NAME  | ADDRESS     | CITY_STATE   | CREDIT_CARD     |
    |Donald Duck | 20 WW       | San,CA 22222 | 411111111111111 |
    And the order summary exist with the order history:
    | 3_Months_Kit | Shipping     | Tax     | Order_total  |
    | $99.99       | FREE         | $5.00   | $104.99      |

  @javascript
  Scenario: The order history should match with current data
    Given I am logged in with email "test@littlesparks.com"
    And I am on your order history page
    And I wanna sleep "1" seconds
    Then I should see "2183005924" on "ORDER" column of the table
    And I should see "01/21/2013 " on "DATE" column of the table
    And I should see "Mickey Mouse" on "RECIPIENT" column of the table
    And I should see "Peter Pan" on "CHILD" column of the table
    And I should see "3-Months Kit " on "PLAN" column of the table

  @javascript
  Scenario: The order history detail should match with current data
    Given I am logged in with email "test@littlesparks.com"
    And I am on your order history page
    When I click "2183005924" on "ORDER" column
    Then I should see "2183005924" near "ORDER NUMBER" label
    And I should see "01/21/2013 " near "Order placed" label
    And I should see "Peter Pan" near "For Little Spark" label

    And I should see "Mickey Mouse" on "SHIPPING INFORMATION" section
    And I should see "10 WW" on "SHIPPING INFORMATION" section
    And I should see "San,AK 11111" on "SHIPPING INFORMATION" section

    And I should see "Donald Duck" on "PAYMENT INFORMATION" section
    And I should see "20 WW" on "PAYMENT INFORMATION" section
    And I should see "San,CA 22222" on "PAYMENT INFORMATION" section

    And I should see "3-Months Kit" on "ORDER SUMMARY" section
    And I should see "$99.99" on "ORDER SUMMARY" section
    And I should see "$5.00" on "ORDER SUMMARY" section
    And I should see "$104.99" on "ORDER SUMMARY" section

  @javascript
  Scenario: The order history detail should match with current data
    Given I am logged in with email "test@littlesparks.com"
    And I am on your order history page
    When I click "2183005924" on "ORDER" column
    And I click "RETURN TO COMPLETE ORDER HISTORY" button
    And I wanna sleep "4" seconds
    Then I should see "your order history" table






