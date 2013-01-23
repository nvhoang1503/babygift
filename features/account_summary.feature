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