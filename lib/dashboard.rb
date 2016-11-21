require "./lib/geolocation"
require "./lib/weather"
require "./lib/headlines"
require "./lib/events"
require "sinatra/base"
require 'pry'

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do
    @ip = request.ip
    @geolocation = Geolocation.new(@ip)
    @weather_report = Weather.new(@geolocation.state, @geolocation.city)
    @events = Events.new(@geolocation.state, @geolocation.city)
    @headlines = Headlines.new
    erb :dashboard
  end
end
