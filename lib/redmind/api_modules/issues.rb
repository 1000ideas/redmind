module Redmind
	module APIModules
		module Issues
			module InstanceMethods

				def issues
					result = get_json "issues"

					result["issues"]
				end

				def total_issues_count
					result = get_json "issues"

					result["total_count"]
				end
			end

			def self.included(receiver)
				receiver.send :include, InstanceMethods
			end
		end
	end
end