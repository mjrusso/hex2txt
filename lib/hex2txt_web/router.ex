defmodule Hex2txtWeb.Router do
  use Hex2txtWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {Hex2txtWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Hex2txtWeb do
    pipe_through :browser

    get "/", PageController, :home

    get "/:package/llms.txt", PageController, :llms_txt
    get "/:package/:version/llms.txt", PageController, :llms_txt
  end

  # Other scopes may use custom stacks.
  # scope "/api", Hex2txtWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:hex2txt, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: Hex2txtWeb.Telemetry
    end
  end
end
