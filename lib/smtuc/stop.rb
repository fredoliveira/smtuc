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

    # Returns a list of all known stops
    def self.all
      response = Faraday.get(API_URL + '/GetStops?oLat=40.20343598944182&oLon=-8.417298279776674&meters=99999999999')
      lines = JSON.parse(response.body)
      lines.map { |line| new(line) }
    end
  end
end
