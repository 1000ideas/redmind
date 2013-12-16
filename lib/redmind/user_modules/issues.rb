module Redmind
	module UserModules
		module Issues
			def self.included(parent)
			end

			def issues
				api = Runner.instance.api

				puts "You have #{api.total_issues_count} issues"
			end
		end
	end
end