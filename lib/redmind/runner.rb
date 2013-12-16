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
			@api ||= API.new
			@api.host = @config.get :host
			@api.token = @config.get :token
		end

		def run args
			case args[0] when "status"
				User.instance.status
			when "issues"
				User.instance.issues.test
			when "authenticate"
				User.instance.authenticate *args.drop(1)
				@api.token = @config.get :token
			else #default - display help
				puts "Unknown command #{args[0]}" if !args.empty? and (args[0] =~ /\bhelp|\?|h\b/).nil?
				puts File.read(File.expand_path("./help.md"))
			end
		end
	end
end