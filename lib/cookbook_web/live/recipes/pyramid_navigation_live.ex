defmodule CookbookWeb.PyramidNavigationLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, selection: nil)}
  end

  def render(assigns) do
    ~H""
  end

  def handle_event("select", %{ "selection" => index }, socket) do
    {:noreply, assign(socket, selection: String.to_integer(index))}
  end

  def handle_event("done", _params, socket) do
    {:noreply, assign(socket, selection: nil)}
  end

  def handle_event("previous", _params, %{ assigns: %{ selection: selection } } = socket) when selection > 0 do
    {:noreply, assign(socket, :selection, selection - 1)}
  end
  def handle_event("previous", _params, socket), do: {:noreply, socket}

  def handle_event("next", _params, %{ assigns: %{ selection: selection } } = socket) when selection < 25 do
    {:noreply, assign(socket, :selection, selection + 1)}
  end
  def handle_event("next", _params, socket), do: {:noreply, socket}
end
