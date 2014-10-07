class StationsController < ApplicationController
  
  # Set up the station information
  
	def index
  		@station = Station.new
  		@stations = get_station_names
  	end

  	def create
  		binding.pry
  		@departure = Departure.new
  		@departures = @departure.get_departures
  	end

  	def new
  		binding.pry
  	end

	# Get the current list of station names from BART

	def get_station_names

		# Typhoeus is used to submit http requests

		  response = Typhoeus.get("http://api.bart.gov/api/stn.aspx?cmd=stns&key=ZZLI-UU93-IMPQ-DT35")

		  # Extract the station names and short names

		  response_XML = Nokogiri.XML(response.body)

		  @station_names = {}

		  # Create a hash list of the station names and abbreviations
		  # node provides the full name of the station and next node is 
		  # the abbreviation

		  response_XML.xpath("//stations/station/name").each do |node|
		  		@station_names[node.text] = node.next.text
		  end

		  return @station_names

	end

  	
end
