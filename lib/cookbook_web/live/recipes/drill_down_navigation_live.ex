defmodule CookbookWeb.DrillDownNavigationLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(%{ "index" => index }, _session, socket) do
    {:ok, assign(socket, title: index)}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, title: "Drill Down")}
  end

  def render(assigns) do
    ~H""
  end
end
