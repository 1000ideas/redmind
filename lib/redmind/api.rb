require 'rubygems'
require 'json'
require 'open-uri'
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