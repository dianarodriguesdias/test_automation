@OS @movie
Feature: Delete movie

  @test#5
  Scenario: Delete movie
    Given the customer is logged in
    And user checks if movie "QAD Movie Test" exist
    And user deletes the movie
    Then the movie was deleted with success

