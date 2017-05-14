And 'I click on a calendar icon' do
  frontend.click_on_calendar
end

And 'I select scheduled date' do
  frontend.select_scheduled_date('calendar')
end

### Expects

Given(/^I set a tweet date$/) do
  frontend.select_scheduled_date('dialog')
  expect(frontend.correct_date_selected?(tweet)).to be true
end

Then(/^I can see my scheduled tweet$/) do
  raise 'No scheduled tweets were found' unless frontend.scheduled_tweet
  tweet_message = frontend.scheduled_tweet.text
  expect(tweet_message).to eq(tweet[:text])
end

### Combined steps

When 'I schedule a tweet' do
  step 'I click "Compose" link'
  step 'I click on a calendar icon'
  step 'I set a tweet date'
  step 'I type a "random" message in a twitter text field'
  step 'I "schedule" the tweet'
end

Then 'The tweet should be scheduled' do
  step 'I go to publishing'
  step 'I click "Scheduled"'
  step 'I select scheduled date'
  step 'I can see my scheduled tweet'
end
