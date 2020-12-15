Feature: Logout
    The user should be able to logout

    Scenario: User logs out when clicking logout button
        Given I am "logged" in
        When I tap the "logout" button
        Then I expect the "register" to be "Register"