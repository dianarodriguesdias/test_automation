@OS @people
Feature: Create person

  @test#6
  Scenario: Create person
    Given the customer is logged in
    And user navigates to people tab
    And user navigates to people form
    When user fills all fields in movie form with person name "OS User"
    Then the person is created with success

