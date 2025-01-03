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

    live "/", MapsLive
    scope "/recipes" do
      live "/card-row", CardRowLive, metadata: %{
        title: "Card Row",
        icon: "square.stack.fill",
        description: "Auto-sized cards that snap when scrolling",
        category: "UI"
      }
      live "/charts", ChartsLive, metadata: %{
        title: "Charts",
        icon: "chart.xyaxis.line",
        description: "Swift Charts addon library",
        category: "Addons"
      }
      live "/drill-down-navigation", DrillDownNavigationLive, metadata: %{
        title: "Drill-Down Navigation",
        icon: "list.bullet.indent",
        description: "Navigation method that navigates to nested pages",
        category: "Navigation"
      }
      live "/file-upload", FileUploadLive, metadata: %{
        title: "File Upload",
        icon: "folder",
        description: "Upload files with the fileImporter modifier",
        category: "UI"
      }
      live "/gesture", GestureLive, metadata: %{
        title: "Gesture",
        icon: "hand.draw.fill",
        description: "Use `gesture_state` to create fluid interactions",
        category: "UI"
      }
      live "/hub-and-spoke-navigation", HubAndSpokeNavigationLive, metadata: %{
        title: "Hub & Spoke Navigation",
        icon: "arrow.up.left.and.down.right.and.arrow.up.right.and.down.left",
        description: "Navigation method that navigates to and from independent pages",
        category: "Navigation"
      }
      live "/maps", MapsLive, metadata: %{
        title: "Maps",
        icon: "mappin.and.ellipse",
        description: "MapKit addon library",
        category: "Addons"
      }
      live "/media-overview", MediaOverviewLive, metadata: %{
        title: "Media Overview",
        icon: "play.square.stack",
        description: "Apple Music/Podcasts-styled album overview",
        category: "UI"
      }
      live "/message-thread", MessageThreadLive, metadata: %{
        title: "Message Thread",
        icon: "message.fill",
        description: "A list of message bubbles that starts at the bottom",
        category: "UI"
      }
      live "/onboarding", OnboardingLive, metadata: %{
        title: "Onboarding",
        icon: "list.star",
        description: "A list of features available in the app",
        category: "UI"
      }
      live "/playback-bar", PlaybackBarLive, metadata: %{
        title: "Playback Bar",
        icon: "playpause.fill",
        description: "An expandable bar that shows currently playing media",
        category: "UI"
      }
      live "/pyramid-navigation", PyramidNavigationLive, metadata: %{
        title: "Pyramid Navigation",
        icon: "point.3.filled.connected.trianglepath.dotted",
        description: "Navigation method that allows navigation between sibling pages",
        category: "Navigation"
      }
      live "/scroll-automation", ScrollAutomationLive, metadata: %{
        title: "Scroll Automation",
        icon: "arrow.up.and.down.text.horizontal",
        description: "Programatically change the scroll position",
        category: "UI"
      }
      live "/search", SearchLive, metadata: %{
        title: "Search",
        icon: "magnifyingglass",
        description: "A search bar that sends live updates, and detects the submit button.",
        category: "UI"
      }
      live "/sectioned-grid", SectionedGridLive, metadata: %{
        title: "Sectioned Grid",
        icon: "square.grid.3x3.fill",
        description: "A grid of items divided into pinned section headers",
        category: "UI"
      }
      live "/tabs", TabsLive, metadata: %{
        title: "Tabs",
        icon: "rectangle.split.3x1.fill",
        description: "Navigation method that uses a system tab bar",
        category: "Navigation"
      }
      live "/video", VideoLive, metadata: %{
        title: "Video",
        icon: "play.rectangle.fill",
        description: "AVKit addon library for video playback",
        category: "Addons"
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
