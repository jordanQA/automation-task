require_relative '../../lib/frontend/base'
require_relative '../../lib/frontend/twitter'
require_relative '../../lib/frontend/calendar'
require_relative '../../lib/customer/base'
require_relative '../../lib/tweet/base'
require_relative '../../lib/host'

module NavigationHelpers
  def frontend
    return @frontend if @frontend
    @frontend ||= Frontend::Base.new(customer, tweet)
  end

  def customer
    @customer ||= Customer::Base.new
  end

  def tweet
    @tweet ||= Tweet::Base.new
  end
end

World(NavigationHelpers)
