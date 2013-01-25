Feature: Children and plan
  In order to update children and plan
  As a nomal user
  I want to review and update children and plan info

  Background:
    Given a user exists with email: "test@littlesparks.com", password: "123123"
      And user "test@littlesparks.com" has children
        |first_name|last_name |birthday  |gender|
        |ABC       |ABCD      |12/12/2012|1     |
        |XYZ       |XYZO      |12/12/2012|0     |
      And I have some orders
        |baby    |plan_type|price|
        |ABC ABCD|1        |1230 |
        |XYZ XYZO|        2| 2500|


  @javascript
  Scenario: access children and plan page
    Given I go to the login page
    When I log in with email "test@littlesparks.com" and password "123123"
      And clicking on top-right corner I go to My Account page
    Then I should see the welcome sentence at the top-left page
      And I should see edit link next to Children and Plan text
      When clicking on edit link I go to Children and Plan page
    Then I should see the title of Children and Plan page
      And I should see the title of page in the left menu highlighted
      And I should see the list of children's header
      And I should see the list of my children in the middle section
      And I should see text and link in the bottom of page to enroll a new child
    When I click on Sign him or her up here
      Then I should see the title of Enroll page

  @javascript
  @current
  Scenario: access children and plan edition page
    Given I go to the login page
    When I log in with email "test@littlesparks.com" and password "123123"
      And clicking on top-right corner I go to My Account page
      And clicking on edit link I go to Children and Plan page
      And clicking on edit link of first child
    Then I should see the title of Children and Plan edition page

