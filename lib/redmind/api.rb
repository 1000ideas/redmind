require 'rubygems'
require 'json'
require 'open-uri'

module Redmind
	class API
		attr_accessor :host, :token

		def current_user
			result = get_json "users/current"

			result["user"]
		end

		private
		def get_json(*options)
			result = call( *options )
			JSON.parse result
		end

		def call(*options)
			if options.class == Hash
				method = options.delete(:method)
				@token = options.delete(:token) || @token
				@host = options.delete(:host) || @host
			elsif options.class == Array and options.length == 1
				method = options.first
			else
				raise "Wrong parameters in call to Redmine API #{options.inspect}"
			end

			uri = @host + method + ".json"
			headers = {
				"X-Redmine-API-Key" => @token
			}

			open(uri, headers).read
		end
	end
end