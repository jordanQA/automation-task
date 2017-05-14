# -*- coding: utf-8 -*-
require_relative '../../lib/tweet/base'
require_relative '../../lib/frontend/twitter'
require_relative '../../features/support/wait_for_ajax'
require 'date'

module Frontend
  class Base
    include ::RSpec::Matchers
    include Capybara::DSL
    attr_reader :customer
    attr_reader :tweet

    def initialize(customer, tweet)
      @customer = customer
      @tweet = tweet
    end

    def to_page(page)
      Host.set
      url =
        case page
        when 'home', 'home page'        then '/'
        when 'messages', 'my messages'  then'/messages'
        when 'scheduled'                then '/publishing/scheduled'
        when 'publishing'               then '/publishing'
        else
          raise "No such page - '#{page}'. Please provide correct page name."
        end
      visit url
    end

    def login(username, password, remember = false)
      input_credentials(username, password)
      check(find('.Form-checkbox')) if remember
      click_on 'Log In'
    end

    def write_tweet_text(text, length = 50)
      Frontend::Twitter.write_text(text, length)
    end

    def post_tweet(command)
      Frontend::Twitter.post_tweet(command)
    end

    def scheduled_tweet
      Frontend::Twitter.scheduled_tweet
    end

    def click_on_calendar
      Frontend::Calendar.click_on_calendar
    end

    def select_scheduled_date(frame)
      Frontend::Calendar.select_scheduled_date(frame, tweet)
    end

    def correct_date_selected?(tweet)
      Frontend::Calendar.correct_date_selected?(tweet)
    end

    def tweet_reply(tweet)
      Frontend::Twitter.click_reply(tweet)
    end

    def delete_tweet(page)
      case page
      when 'messages'   then Frontend::Twitter.delete_tweet_from_messages
      when 'scheduled'  then Frontend::Twitter.delete_tweet_from_scheduled
      else 'Please, provide a correct page where you want to delete your tweet.'
      end
    end

    private

    def input_credentials(username, password)
      fill_in :signin_email, with: username
      fill_in :signin_pw, with: password
    end

    def login_successful?
      page.has_xpath?('//a[@title="Actions"]')
    end
  end
end
