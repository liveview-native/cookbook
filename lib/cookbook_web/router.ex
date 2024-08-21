defmodule CookbookWeb.Router do
  use CookbookWeb, :router

  pipeline :browser do
    plug :accepts, [
      "html",
      "swiftui"
    ]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout,
      html: {CookbookWeb.Layouts, :root},
      swiftui: {CookbookWeb.Layouts.SwiftUI, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CookbookWeb do
    pipe_through :browser

    live "/", CookbookLive

    scope "/recipes" do
      live "/card-row", CardRowLive, metadata: %{
        title: "Card Row",
        icon: "square.stack.fill",
        description: "Auto-sized cards that snap when scrolling"
      }
      live "/drill-down-navigation", CardRowLive, metadata: %{
        title: "Drill-Down Navigation",
        icon: "list.bullet.indent",
        description: "Navigation method that navigates to nested pages"
      }
      live "/gesture", GestureLive, metadata: %{
        title: "Gesture",
        icon: "hand.draw.fill",
        description: "Use `gesture_state` to create fluid interactions"
      }
      live "/hub-and-spoke-navigation", HubAndSpokeNavigationLive, metadata: %{
        title: "Hub & Spoke Navigation",
        icon: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left",
        description: "Navigation method that navigates to and from independent pages"
      }
      live "/message-thread", MessageThreadLive, metadata: %{
        title: "Message Thread",
        icon: "message.fill",
        description: "A list of message bubbles that starts at the bottom"
      }
      live "/playback-bar", PlaybackBarLive, metadata: %{
        title: "Playback Bar",
        icon: "playpause.fill",
        description: "An expandable bar that shows currently playing media"
      }
      live "/pyramid-navigation", PyramidNavigationLive, metadata: %{
        title: "Pyramid Navigation",
        icon: "point.3.filled.connected.trianglepath.dotted",
        description: "Navigation method that allows navigation between sibling pages"
      }
      live "/search", SearchLive, metadata: %{
        title: "Search",
        icon: "magnifyingglass",
        description: "A search bar that sends live updates, and detects the submit button."
      }
      live "/sectioned-grid", SectionedGridLive, metadata: %{
        title: "Sectioned Grid",
        icon: "square.grid.3x3.fill",
        description: "A grid of items divided into pinned section headers"
      }
      live "/tabs", TabsLive, metadata: %{
        title: "Tabs",
        icon: "rectangle.split.3x1.fill",
        description: "Navigation method that uses a system tab bar"
      }
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookbookWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:cookbook, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CookbookWeb.Telemetry
    end
  end
end
