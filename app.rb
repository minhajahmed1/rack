require 'rack'
require 'cgi'
require 'json'
require 'http-cookie'
require_relative 'route'
require_relative 'template'
require_relative 'authentication'


class App
  # method recieves an arguement from rack and returns http response object
  def call(env)
    request = Rack::Request.new(env)
    response_headers = {}
    route = Route.new(env)
    status = route.name =~ /^\d\d\d$/ ? route.name.to_i : 200
    template_data = {}
    template = Template.new(route.name, template_data)
 
   	if env["REQUEST_METHOD"] == "POST"
      params = CGI::parse(env["rack.input"].read)
      survey_data = {}
      survey_data[:employability] = params["employability"] && params ["employability"].first
      survey_data[:nationality] = params["nationality"] && params["nationality"].first
      survey_data[:income] = params["income"] && params["income"].first
      survey_data[:email] = params["email"] && params["email"].first
        if new_survey?(survey_data[:email])
          answers = existing_answers << survey_data
          open('answers.json', 'w') do |file|
            file.write answers.to_json 
          end
          template_data[:message] = "Survey saved"
          template_data[:success] = true
          survey_cookie = HTTP::Cookie.new("survey_saved", "true" , path: '/')
          response_headers['Set-Cookie'] = survey_cookie.set_cookie_value
        else
          template_data[:message] = "Email already exists"
          template_data[:success] = false 
        end
        template_data[:survey_data] =  survey_data 
    end
    template_data[:survey_saved] = request.cookies["survey_saved"]
    template_data[:answers] = existing_answers
    [status, response_headers, [template.render]]

  end
  def existing_answers
    data = File.read("answers.json")
    data.size > 0 ? JSON.parse(data) : []
  end

  def new_survey? email
    !existing_answers.any? {|a| a['email'] == email}
  end
end  		



   														