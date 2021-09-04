# frozen_string_literal: true

require "net/http"
require "json"

module Notifications
  class Request
    def self.get(url, authorization = nil)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl?(url)
      req = Net::HTTP::Get.new(uri.request_uri)
      req["Authorization"] = authorization
      JSON.parse(http.request(req).body)
    end

    def self.post(url, authorization, body)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl?(url)

      request = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json" })
      request.body = body.to_json
      request["Authorization"] = authorization
      request["Accept"] = "application/json"

      http.request(request)
    end

    def self.patch(url, authorization, body)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl?(url)

      request = Net::HTTP::Patch.new(uri.path, { "Content-Type" => "application/json" })
      request.body = body.to_json
      request["Authorization"] = authorization
      request["Accept"] = "application/json"

      http.request(request)
    end

    def self.use_ssl?(url)
      url.match?(/^https/)
    end
  end
end
