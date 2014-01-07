module Redmind
	module APIModules
		module Issues
			class IssueStatus
				@@avaliable_keys = [:id, :name, :is_default, :is_closed]
				attr_reader *@@avaliable_keys

				def initialize(attrs = {})
					attrs.each do |k, v|
						instance_variable_set("@#{k}", v) if @@avaliable_keys.include?(:"#{k}")
					end
				end

				def close?
					is_closed
				end
			end

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

			def avaliable_statuses
				@statuses ||= get_json('issue_statuses')
					.delete("issue_statuses") { [] }
					.map {|s| IssueStatus.new(s) }
			end

			def close_status
				# Works only with our Redmine
				avaliable_statuses.find { |s| s.id == 5 }
			end

			def update_status(id, status, comment = nil)
				issue = {
					status_id: status.id
				}
				issue['done_ratio'] = 100 if status == close_status
				issue['notes'] = comment unless comment.nil?
				put_json("issues/#{id}", {issue: issue}.to_json )
				puts "Set ##{id} status to #{status.name}"
			end

			def close_issue(id, comment = nil)
				stop_time(id)
				update_status(id, close_status, comment)
			end

			def start_time(id)
				post_json('plugin_app/start_time', issue_id: id)
				puts "Start ##{id}"
			end

			def stop_time(id)
				rsp = post_json('plugin_app/stop_time', issue_id: id)
				time = (rsp["time"] || 0.0)
				if time > 0
					puts "Stop ##{id}. Activity time: %.2f" % [time]
				end
			end

			def log_time(id, time)
				rsp = post_json('plugin_app/add_time', issue_id: id, time: time)
				puts "Add time to ##{id}"
			end

		end
	end
end