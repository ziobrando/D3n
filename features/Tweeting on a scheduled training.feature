Feature: Tweeting on a scheduled training
  As a marketing agent
  I want to tweet immediately upon class scheduling

  Scenario: Immediate tweet on scheduled training
    Given a Twitter Account @testD3N
    When a Training <training> is scheduled for