class Route

  ROUTES = {
    "/" => :home,
    "/admin" => :admin,
    "/authentication" => :authentication
 
  }

  def initialize(env)
    if (env["REQUEST_METHOD"] == "GET")
      @name = ROUTES[env["PATH_INFO"]]
    end
  end

  def name
    @name || "404"
  end
end