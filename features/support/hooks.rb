Before { Capybara.reset_sessions! }

After('@message_clean') do
  frontend.delete_tweet('messages')
end

After('@message_reply_clean') do
  2.times { frontend.delete_tweet('messages') }
end

After('@scheduled_clean') do
  frontend.delete_tweet('scheduled')
end
