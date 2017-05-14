module Customer
  class Base
    def initialize
      @data = {
        email:    'qatests+homework3@sproutsocial.com',
        password: #PASSWORD
      }
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
    end
  end
end
