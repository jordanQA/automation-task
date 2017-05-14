require 'capybara/cucumber'
require 'rspec'
require 'selenium/webdriver'
require 'capybara/poltergeist'
require 'pry'
require_relative 'selectors'
require_relative 'wait_for_ajax'

# ENV['RAILS_ENV'] ||= 'test'
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

Capybara.default_max_wait_time = 20

Capybara.run_server = false
Capybara.register_driver :chrome do |app|
  @client = Selenium::WebDriver::Remote::Http::Default.new
  Capybara::Selenium::Driver.new(app, browser: :chrome, http_client: @client, args: ["--window-size=1650,1080"])
end
Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome

# Capybara.register_driver :poltergeistr do |app|
#   Capybara::Poltergeist::Driver.new(app, {js_errors: false, timeout: 20})
# end
#
# Capybara.default_driver = :poltergeist
# Capybara.javascript_driver = :poltergeist
RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
