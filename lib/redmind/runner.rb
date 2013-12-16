require 'singleton'
require 'redmind/config'
require 'redmind/user'


module Redmind
	class Runner
		include Singleton
		attr_accessor :config, :api

		@config = nil
		def initialize
			@config ||= Config.new
			@config.set host: "https://redmine.1000i.pl/"
			@api ||= API.new(@config)
		end

		def run args
			user = User.instance
			case args[0] when "status"
				user.status
			when "issues"
				user.issues
			when "authenticate"
				user.authenticate *args.drop(1)
			else #default - display help
				puts "Unknown command #{args[0]}" if !args.empty? and (args[0] =~ /\bhelp|\?|h\b/).nil?
				puts File.read(File.expand_path("./help.md"))
			end
		end
	end
end