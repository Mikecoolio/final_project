defmodule FinalProjectWeb.Router do
  use FinalProjectWeb, :router
  alias FinalProjectWeb.AuthController
  alias FinalProjectWeb.Plugs.PopulateAuth
  alias FinalProjectWeb.Plugs.ProtectGraphQL
  alias FinalProjectWeb.PageController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FinalProjectWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :browser

    # get "/", PageController, :index
    get "/", AuthController, :new_login
    get "/registration_page", PageController, :register
    # get "/chat_box", PageController, :index
    get "/chat_box", AuthController, :show_chatbox
    # live "/chat_box", FinalProjectWeb.ChatMessagesLive
    live "/show_all_users", FinalProjectWeb.ShowAllUsersLive
    live "/show_currently_logged_in_user", FinalProjectWeb.ShowCurrentlyLoggedInUser

    # live_session :default, on_mount: [{FinalProjectWeb.AuthController, :current_user}] do
    #   live "chat_messages", FinalProjectWeb.ChatMessagesLive
    # end
  end

  pipeline :api do
    plug :accepts, ["json", "html"]
    plug :fetch_session
    plug PopulateAuth
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug :fetch_session
    plug ProtectGraphQL
  end

  # scope "/users/" do
  #   pipe_through :browser

  #   resources ""
  # end

  scope "/api/" do
    pipe_through :api

    # get "/auth/test", AuthController, :test
    get "/auth/get_current_logged_in_user", AuthController, :get_current_logged_in_user # only for api, not local
    post "/auth/register", AuthController, :register
    post "/auth/login", AuthController, :login
    delete "/auth/logout", AuthController, :logout
  end

  scope "/api/graphql" do
    pipe_through :graphql

    get "/", Absinthe.Plug.GraphiQL,
    schema: FinalProjectWeb.Schema,
    interface: :playground

    post "/", Absinthe.Plug,
    schema: FinalProjectWeb.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", FinalProjectWeb do
  #   pipe_through :api
  # end

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
      # pipe_through :browser
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: FinalProjectWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  # if Mix.env() == :dev do
  #   scope "/dev" do
  #     pipe_through :browser

  #     forward "/mailbox", Plug.Swoosh.MailboxPreview
  #   end
  # end
end
