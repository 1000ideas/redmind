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
					play = issue.has_key?("play")

					puts "##{issue["id"]} | #{issue["project"]["name"]} | #{issue["subject"]} | #{"*" if play}"
				end
			end

			def time(action, id, time = nil)
				action = action.to_sym if action
				id = get_id(id)
				
				raise ArgumentError, "Specify valid issue ID" if id.nil?
				
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

			def close(id, comment)
				id = get_id(id)
				
				raise ArgumentError, "Specify valid issue ID" if id.nil?

				api.close_issue(id, comment)
			end

			private

			def get_id(id)
				if id == "current" or id.nil?
					user_id = api.current_user["id"]

					issue = api.issues.find do |issue|
						issue.has_key?("play") and (issue['assigned_to']["id"] == user_id)
					end
					issue["id"] unless issue.nil?
				else
					id
				end
			end
			
		end
	end
end