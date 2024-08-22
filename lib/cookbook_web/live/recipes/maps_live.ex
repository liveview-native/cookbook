defmodule CookbookWeb.MapsLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(:places, [
        %{ name: "Washington, D.C.", coordinate: [38.8951, -77.0364], icon: "building.columns.fill" },
        %{ name: "New York City", coordinate: [40.730610, -73.935242], icon: "building.2.fill" },
        %{ name: "Philadelphia", coordinate: [39.9526, -75.1652], icon: "bell.fill" },
      ])
      |> assign(:look_around?, false)}
  end

  def render(assigns) do
    ~H""
  end

  def handle_event("look-around", params, socket) do
    {:noreply, assign(socket, :look_around?, true)}
  end
end
