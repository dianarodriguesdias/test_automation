@OS @people
Feature: Search person

  @test#9
  Scenario: Search person
    Given the customer is logged in
    And user navigates to people tab
    And user search for a person "Ford"
    Then the search is completed with success