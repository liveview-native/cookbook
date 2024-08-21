defmodule CookbookWeb.SearchLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, search_text: "", entered_search: "Pull down to search")}
  end

  @spec handle_event(<<_::48, _::_*64>>, any(), any()) :: {:noreply, any()}
  def handle_event("search-changed", %{ "searchText" => search_text }, socket) do
    {:noreply, assign(socket, search_text: search_text)}
  end
  def handle_event("search", _params, socket) do
    {:noreply, assign(socket, entered_search: socket.assigns.search_text)}
  end

  def render(assigns) do
    ~H""
  end
end
