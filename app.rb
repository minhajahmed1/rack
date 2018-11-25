require 'rack'
require 'cgi'
require 'json'
require_relative 'route'
require_relative 'template'
require_relative 'admin'


class App
  # method recieves an arguement from rack and returns http response object
  def call(env)
    response_headers = {}
    request_cookies = Rack::Utils.parse_cookies(env)
    route = Route.new(env)
    status = route.name =~ /^\d\d\d$/ ? route.name.to_i : 200
    template_data = {}
    template = Template.new(route.name, template_data)
 
   	if env["REQUEST_METHOD"] == "POST"
      params = CGI::parse(env["rack.input"].read)
      template_data[:employability] = params["employability"] && params ["employability"].first
      template_data[:nationality] = params["nationality"] && params["nationality"].first
      template_data[:income] = params["income"] && params["income"].first
      template_data[:email] = params["email"] && params["email"].first
        if new_survey?(template_data[:email])
    		  open('answers.json', 'w') do |file|
            answers = existing_answers << template_data
          file.write answers 
          end
        end
    end
 
    [status, response_headers, [template.render]]

  end
  def existing_answers
    JSON.parse(File.read "answers.json") rescue []
  end

  def new_survey? email
    !existing_answers.find {|a| a[:email] == email}
  end
end  		



   														