require 'sinatra/base'
require 'rack'
require 'erb'
require 'json'
require_relative 'app'
require_relative 'route'
class Admin < Sinatra::Base



hi = File.foreach("answers.json").map { |x| JSON.parse(x) }


# tried to loop over hash but will not display and loop displays data twice in terminal
hi.each do |person|
  person.each do |key,value|
    puts "the key is #{key} and the value is the #{value}"
  end
end

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'minhaj' && password == 'minhaj'
  end

  get '/'  do

    "#{hi.each do |person|
    person.each do |key,value|
    puts "the key is #{key} and the value is the #{value}"
  end
end
}"
    
 

  end

end

