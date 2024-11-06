defmodule CookbookWeb.ScrollAutomationLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  @lyrics (for i <- 1..100, do: "This is lyric line #{i}")

  def mount(_params, _session, socket) do
    Process.send_after(self(), :tick, 2000)
    {:ok, socket
      |> assign(:lyrics, @lyrics)
      |> assign(:scroll_position, 0)
      |> assign(:user_interacted, false)}
  end

  def render(assigns) do
    ~H""
  end

  def handle_info(:tick, socket) do
    if socket.assigns.user_interacted do
      {:noreply, socket}
    else
      Process.send_after(self(), :tick, 2000)
      {:noreply, assign(socket, :scroll_position, socket.assigns.scroll_position + 1)}
    end
  end

  def handle_event("jump", %{ "line" => line }, socket) do
    {:noreply, socket
      |> assign(:scroll_position, String.to_integer(line))
      |> assign(:user_interacted, false)
    }
  end

  def handle_event("scroll-position-changed", %{ "scroll-position" => nil }, socket) do
    {:noreply, assign(socket, user_interacted: true)}
  end

  def handle_event("scroll-position-changed", _params, socket) do
    {:noreply, socket}
  end
end
