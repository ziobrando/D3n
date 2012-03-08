Feature: Basic training management

  Scenario: Creating and saving a new Training
    Given a Training name My Brand New Training
    And a Training Description like "this is a fantastic training"
    When a user tells to create a Training with the given Name, Description and Duration
    Then a Training named My Brand New Training is available

# Maybe a Spec

  Scenario: Saving a Training allows to recover it via Id
    Given a Training name Generic Training
    And a Training Description like "we'll teach something"
    When a user tells to create a Training with the given Name, Description and Duration
    Then the Training Generic Training is given an Id
    And the Training named Generic Training can be retrieved via Id


