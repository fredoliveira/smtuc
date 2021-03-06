class SMTUC
  class Stop
    attr_accessor :id, :name, :lat, :lon

    # This is a bit hacky because the only way to grab all stops is to do a
    # lat/lon search and expand the range as high as it will go. In theory,
    # this will return every stop in the system.
    API_URL = "#{BASE_API_URL}/Stops".freeze

    def initialize(attributes)
      @id = attributes['Code'].gsub('SMTUC_', '')
      @name = attributes['Name'].strip
      @lat = attributes['CoordX']
      @lon = attributes['CoordY']
    end

    # Because there's no real way through the API to get details on a specific
    # stop, istead we grab all of the stops and filter by id.
    #
    # TODO: maybe there is a chance we can simply cache results locally,
    #       as stops don't even change that often.
    def self.find(id)
      all.select { |s| s.id == id }.first
    end

    # Returns a list of all known stops
    def self.all
      response = Faraday.get(API_URL + '/GetStops?oLat=40.20343598944182&oLon=-8.417298279776674&meters=99999999999')
      JSON.parse(response.body).map { |stop| new(stop) }
    end

    # Returns a list of stops around a specific latitude and longitude.
    # A radius can be specified. If it is not, it falls back to a default of 200m.
    def self.by_location(lat, lon, radius = 200)
      response = Faraday.get(API_URL + "/GetStops?oLat=#{lat}&oLon=#{lon}&meters=#{radius}")
      JSON.parse(response.body).map { |stop| new(stop) }
    end

    def arrivals
      response = Faraday.get(BASE_API_URL + '/NextArrivals/GetScheds?providerName=SMTUC&stopCode=SMTUC_' + id)
      arrivals = JSON.parse(response.body)

      # Response is normally an array that looks like this:
      #
      #   [
      #     {"Key"=>1, "Value"=>["36", "Pr. República", "19"]},
      #     {"Key"=>2, "Value"=>["25T", "Beira Rio", "24"]}
      #   ]
      #
      # We map that to something a little friendlier that looks like this:
      #
      #   [
      #     {
      #       line: "36",
      #       description: "Pr. República",
      #       minutes: 19
      #     }, (...)
      #   ]
      arrivals.map do |l|
        {
          line: l['Value'][0],
          description: l['Value'][1],
          minutes: l['Value'][2].to_i
        }
      end
    end
  end
end
