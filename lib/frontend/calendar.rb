# -*- coding: utf-8 -*-
require_relative '../../features/support/site'

module Frontend
  class Calendar
    extend Capybara::DSL

    class << self

      def click_on_calendar
        find(:xpath, '//button[3]').click
      end

      def select_scheduled_date(frame, tweet)
        frame =
          case frame
          when 'dialog'   then '//*[@class="schedule-content"]'
          when 'calendar' then '//*[@id="subview_cont_calendar"]'
          else raise 'Please, provide correct frame for the calendar'
          end
        select_date(frame, tweet)
      end

      def correct_date_selected?(tweet)
        full_actual_date = find('.multi-schedule-date').text
        full_expected_date = "#{tweet[:month_short]} #{tweet[:day_short]}, #{tweet[:year]}"
        full_actual_date == full_expected_date
      end

      private

      def select_date(frame, tweet)
        right_arrow = find(:xpath, "#{frame}//*[text()='Next']")
        right_arrow.click until correct_month_selected?(frame, tweet) || right_arrow.nil?
        find(:xpath, "#{frame}//a[@href='#' and text()='#{tweet[:day]}']").click
      end

      def correct_month_selected?(frame, tweet)
        month = find(:xpath, "#{frame}//*[@class='ui-datepicker-month']").text
        year =  find(:xpath, "#{frame}//*[@class='ui-datepicker-year']").text
        (month == tweet[:month]) && (year == tweet[:year])
      end
    end
  end
end
