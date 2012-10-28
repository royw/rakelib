Feature: Application Version
  Scenario: A version constant is available
    Given the application module, Example
    When  the VERSION constant is read
    Then  the version value is a non-nil string
    And   the version is a string that matches the regex: /^\d+\.\d+\.\d+$/
