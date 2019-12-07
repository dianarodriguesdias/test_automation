@OS @people
Feature: Edit person

  @test#7
  Scenario: Edit person
    Given the customer is logged in
    And user navigates to people tab
    And user checks if person "OS User" exist
    And user navigates to person form editing person "OS User"
    When user edits surname of the person for "User"
    Then the person was edited with success




