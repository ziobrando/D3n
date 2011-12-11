Feature: Can publish a training on catalog

  Scenario: Publishing a new training
    Given a Catalog
    And a Training gourmet coding not yet published
    When I publish Training gourmet coding on Catalog
    Then Training gourmet coding is available on Catalog
