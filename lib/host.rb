module Host
  module_function

  def set
    Capybara.app_host = 'https://app.sproutsocial.com'
  end
end
