Feature: SendGift
  In order to send a gift
  I don't have to login
  I have to pass 3 steps

  Scenario: Access gift page
    When I go to home page
    When I click 'Gifts' on header
    Then I go to kits page

  Scenario: Validate email of recipient
    When I input email address 'user@gmail.com'
    Then confirm email should be 'user@gmail.com'
