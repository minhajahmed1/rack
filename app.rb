require 'rack'
require 'cgi'
require 'json'
require_relative 'route'
require_relative 'template'
require_relative 'admin'


class App

  def call(env)
    response_headers = {}
    request_cookies = Rack::Utils.parse_cookies(env)
    route = Route.new(env)
    status = route.name =~ /^\d\d\d$/ ? route.name.to_i : 200
    template_data = {
    	visit_count: request_cookies["session_count"].to_i+1
    }
    if env["REQUEST_METHOD"] == "POST"
    	params = CGI::parse(env["rack.input"].read)
    	template_data[:employability] = params["employability"] && params ["employability"].first
    	template_data[:nationality] = params["nationality"] && params["nationality"].first
      template_data[:income] = params["income"] && params["income"].first
      template_data[:email] = params["email"] && params["email"].first
    end
    template = Template.new(route.name, template_data)
 
 	if env["REQUEST_METHOD"] == "POST"
		  json = template_data.to_json
		  open('answers.json', 'a') do |file|
	    	file.puts json 
	   end

     
	end




    [status, response_headers, [template.render]]

  end

end  		



   														