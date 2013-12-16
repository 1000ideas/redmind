require 'singleton'
require "redmind/api"
require "redmind/issues"
require 'io/console'

module Redmind
	class User
		include Singleton
		include Issues


		def status
			if authenticated?
				puts "You are #{current :login}"
				puts "You have #{issues}"
			else
				puts "You are not logged in. Use authenticate to set the token."
			end
		end

		def authenticate(*args)
			if args.empty?
				puts "Provide your Redmine API access token: "
				token = nil
				STDIN.noecho do |io|
					begin
						token = io.gets.chomp
					end while token.empty?
				end
			else
				token = args[0]
			end

			Runner.instance.config.set token: token
		end

		def current(key=nil)
			if key
				Runner.instance.api.current_user[key.to_s]
			else
				Runner.instance.api.current_user
			end
		end

		private
		def authenticated?
			!Runner.instance.config.get( :token ).empty?
		end
	end
end