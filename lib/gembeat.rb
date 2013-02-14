##require "gembeat/version"
require 'net/http'
require 'uri'
require 'json'
require 'yaml'

module Gembeat
  [:token, :use_ssl, :pulse_url].each do |name|
    class_eval "
      @@#{name} = nil unless defined? @@#{name}

      def self.#{name}
        @@#{name}
      end

      def self.#{name}=(value)
        @@#{name} = value
      end
    "
  end

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

  def self.ca_file
    @cert ||= File.expand_path("../../data/ca_cert.pem", __FILE__)
  end

  def self.ca_file=(value)
    @cert = value
  end

  def self.send_pulse
    http = Net::HTTP.new(self.gembeat_uri.host, self.gembeat_uri.port)
    request = Net::HTTP::Post.new(self.gembeat_uri.request_uri, initheader = {'Content-Type' => "application/json"})
    request.body = self.application_hash.to_json

    if self.use_ssl
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.ca_path = self.ca_file
    end

    response = http.request(request)
  end
end
