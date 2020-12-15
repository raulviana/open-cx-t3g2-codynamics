Feature: Login
  The user should be able to login

  Scenario: User logs in if given correct info
    Given I provide my "email" as "allanbp.br@gmail.com" and my "password" as "12345678"
    When I tap the "login" button
    Then I expect the "confirm" to be "Speed Meeting"

  Scenario: User logs in if given correct info
    Given I provide my "email" as "allanbp.br@gmail.com" and my "password" as "12345679"
    When I tap the "login" button
    Then I expect the "error" to be "Error: Something went wrong. User sign in failed."

