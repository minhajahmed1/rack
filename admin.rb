require 'sinatra/base'
require 'rack'
require 'erb'


class Admin < Sinatra::Base

	def admin

	end
    

  

  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'minhaj' && password == 'minhaj'
  end

  get '/'  do
  	"<div>hi for some reason I don't need to put this in a string #{5+5}</div>
  		<p>
  		</div>hello</div>
  		</p>

  	"
  end

end

# class Public < Sinatra::Base
# 	get '/' do
#     	"public"
#  	end

# end







#class Protected < Sinatra::Base

#   use Rack::Auth::Basic, "Protected Area" do |username, password|
#     username == 'foo' && password == 'bar'
#   end

#   get '/' do
#     "secret"
#   end

#   get '/another' do
#     "another secret"
#   end
# end

# class Public < Sinatra::Base
# 	get '/' do
#     	"public"
#  	end

# end









