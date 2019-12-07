@OS @movie
Feature: Edit movie

  @test#4
  Scenario: Edit movie
    Given the customer is logged in
    And user checks if movie "QAD Movie Test" exist
    And user navigates to movie form editing movie "QAD Movie Test"
    When user edits description of the movie for "Long description"
    Then the movie was edited with success

