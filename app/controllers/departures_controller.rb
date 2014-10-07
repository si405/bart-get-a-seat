class DeparturesController < ApplicationController
  
  # Get the departure times for the selected station
  
	def index
  		@departure = Departure.new
  		@departures = @departure.get_departure_times
  	end

  	# Get the current list of estimated departures from BART

	def get_departure_times

		# The requested origination station is in the instance of 
		# station

		# Typhoeus is used to submit http requests

		  response = Typhoeus.get("http://api.bart.gov/api/stn.aspx?cmd=etd&key=ZZLI-UU93-IMPQ-DT35")

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
