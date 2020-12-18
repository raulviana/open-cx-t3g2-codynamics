Feature: Logout
    The user should be able to logout

    Scenario: User logs out when clicking logout button
        Given I provide my "email" as "allanbp.br@gmail.com" and my "password" as "12345678"
        When I tap the "login" button
        Then I expect the "confirm" to be "Speed Meeting"
        Given I am "logged" in
        When I tap the "logout" button
        Then I expect the "register" to be "Register"