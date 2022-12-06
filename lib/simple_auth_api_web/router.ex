defmodule SimpleAuthApiWeb.Router do
  use SimpleAuthApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug :accepts, ["json"]
    plug SimpleAuthApi.Authentication.Guardian.AuthPipeline
  end

  scope "/", SimpleAuthApiWeb do
    pipe_through :api

    post "user/login", SessionController, :new
    post "user/signup", SessionController, :create
    post "user/get-user", UsuarioController, :verificar_disponibilidade
    get  "user/get-profile/:username", UsuarioController, :listar_posts_username
    get  "user/get-post/:id", UsuarioController, :get_posts



  end
  scope "/api", SimpleAuthApiWeb do
    pipe_through :auth
    post "/user/post", UsuarioController, :publicar_post
    get  "/user/get-post/:id", UsuarioController, :listar_posts
  end


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: SimpleAuthApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
