class Route
  ROUTES = {
    "GET" => {
      "/"  => :home,
      "/admin"  => :admin,
      "/check" => :check

    },
    "POST" => {
      "/" => :check
    }
  }

  attr_accessor :name

  def initialize(env)
    path = env["PATH_INFO"]
    http_method = env["REQUEST_METHOD"]
    @name = (ROUTES[http_method] && ROUTES[http_method][path]) || :not_found
  end
end