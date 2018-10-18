class Route

  ROUTES = {
    "/home" => :home

  }

  attr_accessor :name
  #if HTTP_METHOD is GET than return Path info
  def initialize (env)
    @name = env["HTTP_METHOD"] == "GET" && Routes[env["PATH_INFO"]]
  end
end
