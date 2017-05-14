Feature: Send messages
  In order to send messages to my twitter account
  As a user
  I should verify that I am able to do that

  Background:
    Given I go to home page
    And   I login to my account with "valid" credentials
    And   I click "Compose" link

  @message_clean
  Scenario: Compose new message
    Given I type a "random" message in a twitter text field
    When  I "send" the tweet
    Then  I should see my tweet

  Scenario Outline: Compose empty message
    Given I type an "<empty_type>" message in a twitter text field
    When  I "send" the tweet
    Then  Tweet should not be sent
    Examples:
      | empty_type  |
      | spaces only |
      | empty       |

  Scenario: Compose too long message
    Given I type a "too long" message in a twitter text field
    When  I "send" the tweet
    And   "send" button should be disabled
    Then  Tweet should not be sent

  @message_reply_clean
  Scenario: Reply to a tweet
    When  I reply to a tweet in a tweet-view
    Then  I should see my tweet

  @message_reply_clean
  Scenario: View conversations
    Given I reply to a tweet in a tweet-view
    When  I click on conversation icon
    Then  I should see my tweet in a conversations block

  Scenario: Delete tweet
    Given I type a "random" message in a twitter text field
    And   I "send" the tweet
    And   I should see my tweet
    When  I delete the tweet from the "messages" page
    Then  I should not see my tweet


