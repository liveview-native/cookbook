defmodule CookbookWeb.ModalsLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(:modal_type, nil)
      |> assign(:form, to_form(%{ "type" => "" }))}
  end

  def render(assigns) do
    ~H""
  end

  def handle_event("open", %{ "type" => type }, socket) do
    {:noreply, assign(socket, :modal_type, type)}
  end

  def handle_event("presentation-changed", _params, socket) do
    {:noreply, assign(socket, :modal_type, nil)}
  end
end
