# Load bundle gems
require 'rubygems'
require 'bundler/setup'
require 'faraday'
require 'json'

API_URL = 'http://coimbra.move-me.mobi/Lines/GetLines?providerName=SMTUC'.freeze

module SMTUC
  class Line
    attr_reader :id, :description

    def initialize(attributes)
      @id = attributes['Key'].gsub('SMTUC_', '')
      @description = attributes['Value'].gsub(@id + ' ', '')
    end

    def self.all
      response = Faraday.get(API_URL)
      lines = JSON.parse(response.body)
      lines.map { |line| new(line) }
    end

    def self.find(id)

    end
  end
end

for line in SMTUC::Line.all
  puts line.inspect
end
