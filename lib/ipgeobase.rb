# frozen_string_literal: true

require_relative "ipgeobase/version"
require 'uri'
require 'net/http'
require 'happymapper'
require "addressable/uri"

module Ipgeobase
  class Error < StandardError; end
  # Your code goes here...
  class IpData
    include HappyMapper

    tag 'query'
    element :city, String, tag: 'city'
    element :country, String, tag: 'country'
    element :countryCode, String, tag: 'countryCode'
    element :lat, Integer, tag: 'lat'
    element :lon, Integer, tag: 'lon'
  end

  def self.lookup(ip)
    uri = Addressable::URI.parse("http://ip-api.com/xml/#{ip}")
    res = Net::HTTP.get(uri)
    IpData.parse(res)
  end
end
