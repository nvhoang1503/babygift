Feature: Account summary
  In order to review account information
  As a nomal user
  I want to see account information and update something

  Background: 
  	Given a user exists with email: "test@littlesparks.com", password: "123123"

  @javascript 
  Scenario: access account summary page 
  	Given I go to the login page
  	When I log in with email "test@littlesparks.com" and password "123123"
  	  And clicking on top-right corner I go to My Account page
    Then I should see the welcome sentence at the top-left page
      And I should see links in the left menu 
      And I should see title of Account Summary page
      And I should see Name, Email, Password section in the middle
      #And I should see Payment Information section in the middle
      And I should see Your Children and Plan section in the middle 
    
    
