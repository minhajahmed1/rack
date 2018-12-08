# require 'sinatra/base'
# require 'rack'
# require 'erb'
# require 'json'
# require_relative 'app'
# require_relative 'route'
# class Admin < Sinatra::Base



# answers = File.foreach("answers.json").map { |x| JSON.parse(x) }



#   use Rack::Auth::Basic, "Protected Area" do |username, password|
#     username == 'minhaj' && password == 'minhaj'
#   end

#   get '/'  do

#     "#{answers.each do |person|
#         person.each do |key,value|
#           puts "the key is #{key} and the value is the #{value}"
#         end
#       end
#     }"
#   end

# end

require 'rack'
require 'json'
require_relative 'app'
require_relative 'route'

class Authentication < Rack::Auth::Basic
  def call(env)
    if (env['PATH_INFO'] =~ /admin/)
      super
    else
      @app.call(env)
    end

  end

end
