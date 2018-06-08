class SMTUC
  class Line
    attr_accessor :id, :description, :directions

    API_URL = 'http://coimbra.move-me.mobi/Lines'.freeze

    # Directions are returned in a funky format that makes little sense, but
    # looks like: 'R§Volta§Tovim - Est. Nova'
    #
    # So we define a regex that captures all 3 parts into capture groups:
    # 1: R
    # 2: Volta
    # 3: Tovim - Est. Nova
    DIRECTION_REGEX = /([a-zA-Z0-9_])§([a-zA-Z0-9_]*)§(.*)/

    def initialize(id, description, directions = nil)
      @id = id
      @description = description
      @directions = directions if directions
    end

    # Returns a list of all known lines
    def self.all
      response = Faraday.get(API_URL + '/GetLines?providerName=SMTUC')
      lines = JSON.parse(response.body)
      lines.map { |line| new_from_json(line) }
    end

    # Returns information about a specific line
    def self.find(id)
      # Because there's no known endpoint for specific line details, we
      # fetch all of them and get the id/description information from that.
      # This is a bit gross and maybe there's a simpler way I'm not seeing
      line = all.select { |l| l.id == id }.first

      # Augment the line object with directions from the directions endpoint.
      response = Faraday.get(API_URL + '/GetDirections?lineCode=SMTUC_' + id.to_s)
      line.directions = JSON.parse(response.body).map { |d| parse_directions(d) }

      # Return the final object
      line
    end

    # Initialize a Line object based on API information
    def self.new_from_json(attributes)
      # Key is typically SMTUC_<id>, so we retain just the id
      id = attributes['Key'].gsub('SMTUC_', '')
      # Line includes the id again in most cases, so we strip it out
      description = attributes['Value'].gsub(id + ' ', '')
      # Initialize the line object based on the json
      new(id, description)
    end

    # Returns a parsed direction object based on the way directions are reported
    def self.parse_directions(directions)
      # Match the directions using the regex defined above
      matches = DIRECTION_REGEX.match(directions)

      # Return a final direction object that looks like:
      # {
      #   direction: "volta",
      #   description: "Tovim - Est. Nova"
      # }
      { direction: matches[2].downcase, description: matches[3] }
    end
  end
end
