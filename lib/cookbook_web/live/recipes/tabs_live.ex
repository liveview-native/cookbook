defmodule CookbookWeb.TabsLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{ "tab" => tab }, _session, socket) do
    # restore tab state from query params
    {:noreply, assign(socket, tab: tab)}
  end

  def handle_params(_params, _session, socket) do
    # set a default tab
    {:noreply, assign(socket, tab: "1")}
  end

  def handle_event("tab-changed", %{ "selection" => tab }, socket) do
    # add query param when tab changes
    {:noreply, push_patch(socket, to: ~p"/navigation/tabs?tab=#{tab}", replace: true)}
  end

  def render(assigns) do
    ~H""
  end
end
