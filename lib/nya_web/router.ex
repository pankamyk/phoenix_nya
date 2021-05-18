defmodule NyaWeb.Router do
  use NyaWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :guardian do
    plug(Nya.Guardian.Pipeline)
  end

  pipeline :authorize do
    plug(Guardian.Plug.EnsureAuthenticated)
  end

  scope("/", NyaWeb) do
    pipe_through([:browser, :guardian])

    get("/", PageController, :index)
    resources("/users", UserController)
  end

  scope("/api/v1/", NyaWeb) do
    pipe_through([:api, :guardian])
  end

  # Other scopes may use custom stacks.
  # scope "/api", NyaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  #if Mix.env() in [:dev, :test] do
  #  import Phoenix.LiveDashboard.Router

  #  scope "/" do
  #    pipe_through :browser
  #    live_dashboard "/dashboard", metrics: NyaWeb.Telemetry
  #  end
  #end
end
