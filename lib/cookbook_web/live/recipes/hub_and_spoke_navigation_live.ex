defmodule CookbookWeb.HubAndSpokeNavigationLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, selection: nil)}
  end

  def render(assigns) do
    ~H""
  end

  def handle_event("select", %{ "index" => index }, socket) do
    {:noreply, assign(socket, selection: String.to_integer(index))}
  end

  def handle_event("done", _params, socket) do
    {:noreply, assign(socket, selection: nil)}
  end
end
