class weather

  def initialize(city, state)
    city.empty? ? @city = default_location["city"] : @city = city
    state.empty? ? @state = default_location["region_code"] : @state = state
    @data = get_report
  end

  def get_report
    get_weather
  end

  def weather
    @data["current_observation"]["weather"]
  end

  def temperature
    @data["current_observation"]["tempurature_string"]
  end

  def relative_humidity
    @data["current_observation"]["relative_humidity"]
  end

  def wind
    @data["current_observation"]["wind_string"]
  end

  private

  def get_weather
    response = Net::HTTP.get_response(uri)
    puts JSON.parse(response.body)
  end

  def uri
    URI("http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/#{@state}/#{@city.gsub(" ", "_")}.json")
  end

  def default_location
    {
      "ip" => @ip,
      "country_code" => "US",
      "country_name" => "United States",
      "region_code" => "MA",
      "region_name" => "Massachusetts",
      "city" => "Boston",
      "zip_code" => "02124",
      "time_zone" => "America/New_York",
      "latitude" => 42.2848,
      "longitude" => -71.0741,
      "metro_code" => 506
    }
  end
end
