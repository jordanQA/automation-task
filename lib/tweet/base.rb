module Tweet
  class Base
    def initialize
      @data = {
        hour: hour,
        minute: minute,
        am_pm: am_pm,
        year: year,
        month: month,
        month_short: month_short,
        day: day,
        day_short: day_short
      }
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
    end

    private

    def random_date_time
      return @date_and_time if @date_and_time
      min_date = DateTime.now + 0.4
      max_date = DateTime.now + 170.2
      @date_and_time = rand(min_date..max_date)
    end

    def hour
      random_date_time.strftime('%l').to_s.gsub(' ','')
    end

    def minute
      random_date_time.strftime('%M').to_s.gsub(' ','')
    end

    def am_pm
      random_date_time.strftime('%P')
    end

    def year
      random_date_time.year.to_s
    end

    def month
      random_date_time.strftime('%B')
    end

    def month_short
      random_date_time.strftime('%b')
    end

    def day
      random_date_time.day.to_s
    end

    def day_short
      random_date_time.strftime('%d')
    end
  end
end
