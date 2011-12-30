Feature: Can publish a training on catalog
  Trainings are managed locally,
  However a distinct website is used to make trainings accessible to potential customer.
  Our application serves as a publishing console towards external web sites.

  Scenario: Publishing a new training
    Given a Catalog
    And a Training gourmet coding not yet published
    When I publish Training gourmet coding on Catalog
    Then Training gourmet coding is available on Catalog
