@OS @successful
Feature: Login successful into QS demo

  @test#1
  Scenario: Login successful into QS demo
    Given navigate to QS demo homepage
    And a login is performed in QS demo
    Then Login is "successful"