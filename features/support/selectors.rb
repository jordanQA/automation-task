Capybara.add_selector(:data_qa_button) { xpath { |name| "//*[@data-qa-button='#{name}']" } }
Capybara.add_selector(:data_time_field) { xpath { |name| "//*[@data-time-field='#{name}']" } }
