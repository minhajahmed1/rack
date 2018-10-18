require 'rack'

class VisitCounter
	def initialize(env)
  		@app = app
  	end
	
	def call (env) 
		status, headers, body = @app.call(env)
		response = Rack::response.new body, status, headers
		#gets request_cookie out of the env variable
		request_cookies = Rack::Utils.parse_cookies(env)
	

		unless request_cookies["session_key"]
			response.set_cookie("session_key", {:value => Time.now.to_f})
		end

		count = request_cookies["session_count"].to_i
		count += 1
   	Rack::Utils.set_cookie_header!(response_headers, "session_count", count)

   	response.finish
   end


end