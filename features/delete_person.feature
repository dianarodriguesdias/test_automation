@OS @people
Feature: Delete person

  @test#8
  Scenario: Delete person
    Given the customer is logged in
    And user navigates to people tab
    And user checks if person "OS User" exist
    And user deletes the person
    Then the person was deleted with success