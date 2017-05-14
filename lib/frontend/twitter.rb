# -*- coding: utf-8 -*-
require_relative '../../features/support/site'

module Frontend
  class Twitter
    extend Capybara::DSL

    class << self

      def write_text(text, length)
        text = text == :random ? generate_random_string(length) : text
        find(:xpath, '//textarea[@id]').set(text)
        text
      end

      def post_tweet(command)
        button_xpath = "//button[@data-pollinator-action='#{command}_post']"
        find(:xpath, button_xpath).click
      end

      def scheduled_tweet
        find(:xpath, '//*[contains(@class, "message-text")]//span')
      rescue Capybara::ElementNotFound
        nil
      end

      def delete_tweet_from_messages
        visit '/messages'
        # this one was needed. You have some weird timing for elements to appear
        # so there was an only way to catch a delete icon
        sleep 4
        page.execute_script %($("[title|='Options']:first").trigger('click'))
        find('.delete').click
        click_on 'OK'
        visit '/messages'
      end

      def delete_tweet_from_scheduled
        while page.has_xpath?('//div[contains(@class, "message-text")]')
          page.execute_script "$('[title|=\"Delete This Message\"]:first').trigger('click')"
          click_on 'Delete Message'
        end
      end

      def click_reply(tweet)
        find(:xpath, "//section[*/*/*[text()='#{tweet[:text]}']]//li[*[@title='Reply']]").click
      end

      private

      def generate_random_string(number)
        Array.new(number) { (Array('A'..'Z') + Array('a'..'z') + Array('0'..'9')).sample }.join
      end
    end
  end
end
