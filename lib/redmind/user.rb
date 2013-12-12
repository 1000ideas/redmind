require 'io/console'

module Redmind
	class User
		def initialize

		end

		def authenticate(*args)
			raise "Provide a username and API Token" if args.empty?
			puts "Provide your Redmine API access token: "
			password = nil
			STDIN.noecho do |io|
				password = io.gets.chomp
			end
			puts password.inspect
		end
	end
end