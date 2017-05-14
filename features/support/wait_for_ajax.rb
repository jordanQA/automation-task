class WaitForAjax
  extend Capybara::DSL

  class << self
    def call
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until page.evaluate_script('jQuery.active').zero?
      end
    end
  end
end
