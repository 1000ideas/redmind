module Redmind
	module APIModules
		module Users
			module InstanceMethods
				def current_user
					result = get_json "users/current"

					result["user"]
				end
			end

			def self.included(receiver)
				receiver.send :include, InstanceMethods
			end
		end
	end
end