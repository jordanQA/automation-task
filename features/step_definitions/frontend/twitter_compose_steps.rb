And(/^I login to my account with "(.*?)" credentials$/) do |credentials|
  case credentials
  when 'valid'
    frontend.login(customer[:email], customer[:password])
  when 'invalid'
    frontend.login('invalid@email.com', 'invalid_password')
  else
    raise 'Please, choose from "valid" and "invalid" options'
  end
end


And(/^I type (?:a|an) "(.*?)" message in a twitter text field$/) do |message|
  text =
    case message
    when 'random'         then frontend.write_tweet_text(:random)
    when 'before a reply' then frontend.write_tweet_text('Reply to me!')
    when 'after a reply'  then frontend.write_tweet_text('This is a reply!')
    when 'empty'          then nil
    when 'spaces only'    then frontend.write_tweet_text('   ')
    when 'too long'       then frontend.write_tweet_text(:random, 150)
    else message
    end
  tweet[:text] = text
end

Then(/^I "(.*?)" the tweet$/) do |button|
  frontend.post_tweet(button.downcase)
end

And(/^I reply to a tweet$/) do
  step 'I go to messages'
  frontend.tweet_reply(tweet)
end

And(/^I delete the tweet from the "(.*?)" page$/) do |page|
  frontend.delete_tweet(page)
end

When(/^I click on conversation icon$/) do
  step 'I go to messages'
  conversations_icon = find(:xpath, "(//*[*/*[text()='#{tweet[:text]}']]//*[@class='icon convo'])[1]")
  conversations_icon.click
end

### Expects

Then 'I should see my tweet in a conversations block' do
  conversations = find('#conversation_messages')
  expect(conversations).to have_content(tweet[:text])
end

And(/^"(.*?)" button should be disabled$/) do |button|
  disabled_button_xpath = "//button[contains(@class, 'is-disabled') and @data-pollinator-action='#{button}_post']"
  expect(page).to have_xpath(disabled_button_xpath)
end

Then 'Tweet should not be sent' do
  expect(page).to have_xpath('//button[@tabindex]')
end

Then(/^I should( not)? see my tweet$/) do |negate|
  sleep 3
  step 'I go to messages'
  if negate
    expect(page).not_to have_content tweet[:text]
    # expect(page).not_to have_xpath("//span[text()='#{tweet[:text]}']")
  else
    first_tweet = find(:xpath, '(//article[*[contains(@class, "message-text")]])[1]')

    within first_tweet do
      expect(find('.js-toggle-message-text').text).to eq(tweet[:text])
    end
  end
end

### Combined steps

And 'I reply to a tweet in a tweet-view' do
  step 'I type a "before a reply" message in a twitter text field'
  step 'I "send" the tweet'
  step 'I reply to a tweet'
  step 'I type an "after a reply" message in a twitter text field'
  step 'I click "Send" button'
  step 'I go to messages'
end
