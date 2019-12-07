@OS @people
Feature: Add person

  @test#6
  Scenario: Create person
    Given the user is logged in
    And user navigates to people tab
    And user navigates to people form
    When user fills all fields in person form with person name "QS User"
    Then the person is created with success