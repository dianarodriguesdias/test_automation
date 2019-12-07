@OS @movie
Feature: Add movie

  @test#3
  Scenario: Create movie
    Given the user is logged in
    And user navigates to movie form
    When user fills all fields in movie form with movie title "QS Movie Test"
    Then the movie is created with success