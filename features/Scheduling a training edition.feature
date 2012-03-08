Feature: Scheduling a training edition
  As a manager
  I want to publish a training edition
  On order to sell it

  Scenario: planning an existing training
    Given an existing Training called the same old training
    And a planned delivery date 2012-02-23
    And a selected Location for the class New York
    When I plan an Edition of Training the same old training
    Then an Edition of Training the same old training should be planned for date 2012-02-23