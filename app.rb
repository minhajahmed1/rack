require 'rack'
require_relative 'route'
require_relative 'template'

class App

  def call(env)
    response_headers = {}

   

    request_cookies = Rack::Utils.parse_cookies(env)
    route = Route.new(env)
    status = route.name =~ /^\d\d\d$/ ? route.name.to_i : 200
    template = Template.new(route.name, visit_count: request_cookies["session_count"].to_i+1)

    [status, response_headers, [template.render]]
  end
end



