require "net/http"
require "json"
require "pry"

class Events

  def initialize(state, city)
    city.empty? ? @city = default_location["city"] : @city = city
    state.empty? ? @state = default_location["region_code"] : @state = state
    @data = get_events
  end

  def events
    @data["events"]
  end

  private
  def get_events
    response = Net::HTTP.get_response(uri)
    binding.pry
    JSON.parse(response.body)
  end

  def uri
    today = Time.new.strftime("%Y-%m-%d")
    URI("https://api.seatgeek.com/2/events?datetime_utc.gt=#{today}&geoip=true")
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
