require "net/http"
require "json"

class Headlines

  def initialize
    @data = get_headlines
  end

  def results
    @data["results"]
  end

  private
  def get_headlines
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def uri
    URI("http://api.nytimes.com/svc/topstories/v2/home.json?api-key=#{ENV['NYTIMES_API_KEY']}")
  end
end
