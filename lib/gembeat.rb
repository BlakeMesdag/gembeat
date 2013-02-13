require "gembeat/version"
require 'net/http'
require 'uri'
require 'json'
require 'yaml'

module Gembeat
  mattr_accessor :token
  mattr_accessor :pulse_url

  def self.specs
    @specs ||= Gem.loaded_specs
  end

  def self.dependencies_hash
    @depencies_hash ||= self.specs.map do |name, spec|
      {name: name, version: spec.version.to_s}
    end
  end

  def self.application_hash
    {
      application: {
        token: self.token, dependencies: self.dependencies_hash
      }
    }
  end

  def self.gembeat_uri
    @uri ||= URI.parse(self.pulse_url)
  end

  def self.send_pulse
    http = Net::HTTP.new(self.gembeat_uri.host, self.gembeat_uri.port)
    request = Net::HTTP::Post.new(self.gembeat_uri.request_uri, initheader = {'Content-Type' => "application/json"})
    request.body = self.application_hash.to_json
    response = http.request(request)
  end
end