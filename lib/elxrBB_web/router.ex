defmodule ElxrBBWeb.Router do
  use ElxrBBWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ElxrBBWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Pow.Plug.Session, otp_app: :elxrBB
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  scope "/", ElxrBBWeb do
    pipe_through :browser

    live "/forums", ForumLive.Index, :index
    live "/forums/new", ForumLive.Index, :new
    live "/forums/:id", ForumLive.Show, :show
    live "/forums/:id/edit", ForumLive.Index, :edit
  
    live "/topics", TopicLive.Index, :index
    live "/topics/new", TopicLive.Index, :new
    live "/topics/:id", TopicLive.Show, :show
    live "/topics/:id/edit", TopicLive.Index, :edit
  
    live "/replies", ReplyLive.Index, :index
    live "/replies/new", ReplyLive.Index, :new
    live "/replies/:id", ReplyLive.Show, :show
    live "/replies/:id/edit", ReplyLive.Index, :edit

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElxrBBWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:elxrBB, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ElxrBBWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
