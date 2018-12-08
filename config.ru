#! usr/bin/env ruby
require 'rack'
load 'authentication.rb'
load 'visit_counter.rb'
load 'app.rb'


use Rack::Static, :urls => ['/stylesheet/style.css'], :root => 'public'



use Authentication, "admin" do |username, password|
  (username == 'minhaj') && (password == 'minhaj')
end


use VisitCounter
run App.new
