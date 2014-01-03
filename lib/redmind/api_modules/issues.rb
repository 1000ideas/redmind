module Redmind
	module APIModules
		module Issues
			module InstanceMethods

				def issues
					result = get_json "table_it"

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
				puts "Start ##{id}"
			end

			def stop_time(id)
				rsp = post_json('plugin_app/stop_time', issue_id: id)
				time = (rsp["time"] || 0.0)
				puts "Stop ##{id}. Activity time: %.2f" % [time]
			end

			def log_time(id, time)
				rsp = post_json('plugin_app/add_time', issue_id: id, time: time)
				puts "Add time to ##{id}"
			end

		end
	end
end