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

			def start_time(id)
				post_json('plugin_app/start_time', issue_id: id)
			end

			def stop_time(id)
				post_json('plugin_app/stop_time', issue_id: id)
			end

			def log_time(id, time)
				post_json('plugin_app/add_time', issue_id: id, time: time)
			end

		end
	end
end