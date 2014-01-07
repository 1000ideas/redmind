require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
require 'redmind/api_modules/users'
require 'redmind/api_modules/issues'

module Redmind
	class API
		include APIModules::Users
		include APIModules::Issues
		attr_accessor :host, :token

		def initialize(config)
			@host = config.get :host
			@token = config.get :token
		end



		private

		def http
			@_http ||= Net::HTTP.new(host)
		end

		def get_json(*options)
			result = call( *options )
			JSON.parse result
		end

		def post_json(*args)
			data = args.last.is_a?(::Hash) ? args.pop : {}
			args.push(data: data, type: "POST")
			result = call( *args )
			JSON.parse result
		rescue JSON::ParserError
			{}
		end

		def put_json(*args)
			data = args.pop
			args.push(data: data, type: "PUT")
			result = call( *args )
			JSON.parse result
		rescue JSON::ParserError
			{}
		end

		def call(*args)
			options = args.last.is_a?(::Hash) ? args.pop : {}

			method = args.first || options.delete(:method)
			type = options.delete(:type) || "GET"
			data = options.delete(:data) || ""
			@token = options.delete(:token) || @token
			@host = options.delete(:host) || @host

			if method.nil?
				raise "Wrong parameters in call to Redmine API #{options.inspect}"
			end

			uri = "/#{method}.json"
			headers = {
				"X-Redmine-API-Key" => @token
			}

			query = if data.is_a?(Hash)
				URI.encode_www_form(data)
			else
				headers["Content-Type"] = "application/json"
				data
			end

			response = http.send_request(type, uri, query, headers)
			response.body
		end
	end
end