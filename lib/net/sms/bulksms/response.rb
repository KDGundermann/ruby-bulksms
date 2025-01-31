module Net
	module SMS
		module BulkSMS

			# A response sent by the BulkSMS gateway
			class Response
				attr_reader :code, :description, :batch_id
				
				def initialize(code, description, batch_id)
					@code = code
					@description = description
					@batch_id = batch_id
				end

				def self.parse(response)
					if response.code == "200"
						tokens = response.body.split('|')
						self.new tokens[0].to_i, tokens[1], tokens[2].to_i
					else
						self.new response.code, response.message, 0
					end
				end

				# Was the original request successful?
				def successful?
					(@code == 0) ? true : false
				end
			end
			
		end
	end
end
