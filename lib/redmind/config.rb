require 'rubygems'
require 'json'


module Redmind
	class Config
		@@config_file_path = File.expand_path("./store")
		@@config = nil
		@@runner = nil
		def initialize
			IO.binwrite(@@config_file_path,{}.to_json) unless File.exists?(@@config_file_path)
			@@config = JSON.parse(IO.binread("store")) rescue {}
		end

		def get(name)
			@@config[name.to_s]
		rescue
			nil
		end

		def set(args)
			case args.class.to_s when "Hash"
				@@config = @@config.merge(args.inject({}){|memo,(k,v)| memo[k.to_s] = v; memo})
			when "Array"
				@@config[args[0].to_s] = args[1]
			else
				raise "Too little parameters"
			end

			synchronize
		end

		private
		def synchronize
			IO.binwrite(@@config_file_path,@@config.to_json)
		end
	end
end