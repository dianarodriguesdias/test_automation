@OS @unsuccessful
Feature: Login unsuccessful into QS demo

  @test#2
  Scenario: Login unsuccessful into QS demo
    Given navigate to QS demo homepage
    And a login is performed in QS demo
    Then Login is "unsuccessful"
