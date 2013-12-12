require 'redmind/user'



module Redmind
	class Runner
		def initialize
			@@user ||= User.new
		end

		def run args
			case args[0] when "authenticate"
				@@user.authenticate *args.drop(1)
			else #default - display help
				puts "Unknown command #{args[0]}" if !args.empty? and (args[0] =~ /\bhelp|\?|h\b/).nil?
				puts File.read(File.expand_path("./help.md"))
			end

		rescue Exception => e
			puts e.message
		end
	end
end