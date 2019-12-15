@OS @unsuccessful
Feature: Login unsuccessful into QS demo

  @test#2
  Scenario: Login unsuccessful into QS demo
    Given the user navigates to QS demo homepage
    When a login is performed in QS demo
    Then Login is "unsuccessful"
