@OS @movie
Feature: Create movie

  @test#3
  Scenario: Create movie
    Given the customer is logged in
    And user navigates to movie form
    When user fills all fields in movie form with movie title "QAD Movie Test"
    Then the movie is created with success

