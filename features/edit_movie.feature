@OS @movie
Feature: Edit movie

  @test#4
  Scenario: Edit movie
    Given the user is logged in
    And user checks if movie "QS Movie Test" exists
    And user navigates to movie form editing movie "QS Movie Test"
    When user edits description of the movie for "Long description"
    Then the movie was edited with success