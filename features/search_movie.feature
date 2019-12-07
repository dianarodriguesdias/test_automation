@OS @movie
Feature: Search movie

  @test#5
  Scenario: Search movie
    Given the user is logged in
    And user search for the movie title "Avengers: Infinity War"
    Then the search is completed with success