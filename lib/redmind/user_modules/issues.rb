module Redmind
	module UserModules
		module Issues
			def self.included(parent)
			end

			def api
				@_api ||= Runner.instance.api
			end

			def issues_count
				api.total_issues_count
			end

			def issues
				puts "You have #{issues_count} issues"
				api.issues.each do |issue|
					puts "##{issue["id"]} #{issue["subject"]}"
				end
			end

			def time(action, id, time = nil)
				action = action.to_sym if action
				case action
				when :START then
					api.start_time(id)
				when :STOP then
					api.stop_time(id)
				when :LOG then
					api.log_time(id, time)
				else
					raise ArgumentError, "Unknown action #{action}"
				end
			end
		end
	end
end