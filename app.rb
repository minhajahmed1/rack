require 'rack'
require_relative 'route'
require_relative 'view'

class App
  PAGES = %w{ /home }

  def call(env)
    response_headers = {}

   

    request_cookies = Rack::Utils.parse_cookies(env)
    # set the session identifier if one doesn't already exist
    route = Route.new(env)
    status = route.name =~ /^\d\d\d$/ ? route.name.to_i : 200
    template = Template.new(route.name, visit_count: request_cookies["session_count"].to_i+1)

    [status, response_headers [template.render]]

Rack::Handler::WEBrick.run App.new

