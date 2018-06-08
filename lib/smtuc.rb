# Load bundle gems
require 'rubygems'
require 'bundler/setup'
require 'faraday'
require 'json'

class SMTUC
  BASE_API_URL = 'http://coimbra.move-me.mobi'.freeze
end

require 'smtuc/line'
require 'smtuc/stop'
