When /^(?:|I )go to (.+)$/ do |page_name|
  frontend.to_page(page_name)
  # this one is also needed, even after refresh,
  # information does not get properly updated on a screen
  sleep 3
end

And(/^I click "(.*?)" button$/) do |name|
  click_button(name)
end

And(/^I click "(.*?)" link$/) do |name|
  click_link(name)
end

And(/^I click "(.*?)"$/) do |name|
  click_on(name)
end

