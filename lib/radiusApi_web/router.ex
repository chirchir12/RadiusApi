defmodule RadiusApiWeb.Router do
  use RadiusApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RadiusApiWeb do
    pipe_through :api
    resources "/nas", NasController, except: [:new, :edit]
    post "/nas/reload", NasController, :nas_reload

    post "/users", UserController, :create_user
    get "/users", UserController, :get_users
    get "/users/:id", UserController, :get_user
    put "/users/:id", UserController, :update_user
    delete "/users/:id", UserController, :delete_user
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:radiusApi, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RadiusApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
