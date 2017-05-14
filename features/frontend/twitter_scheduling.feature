Feature: Scheduling messages
  In order to send scheduled messages in a future
  As a user
  I want to schedule a tweet for a future date And see that tweet on my Sprout calendar

  Background:
    Given I go to home page
    And   I login to my account with "valid" credentials

  @scheduled_clean
  Scenario: Schedule a tweet
    When  I schedule a tweet
    Then  The tweet should be scheduled

  Scenario: Delete scheduled tweet
    Given I schedule a tweet
    And   The tweet should be scheduled
    When  I delete the tweet from the "scheduled" page
    Then  I should not see my tweet

