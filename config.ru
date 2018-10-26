#! usr/bin/env ruby
require 'rack'
load 'admin.rb'
load 'visit_counter.rb'
load 'app.rb'




require File.expand_path '../admin.rb', __FILE__

use Rack::Static, :urls => ['/stylesheet/style.css'], :root => 'public'


run Admin.new
run App.new
use VisitCounter

run Rack::URLMap.new({ "/admin" => Admin.new, "/" => App.new })
