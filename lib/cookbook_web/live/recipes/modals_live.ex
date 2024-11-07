defmodule CookbookWeb.ModalsLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(:modal_type, nil)
      |> assign(:form, to_form(%{ "type" => "sheet", "detents" => false }))}
  end

  def render(assigns) do
    ~H""
  end

  def handle_event("form-changed", params, socket) do
    {:noreply, socket
      |> assign(:form, cast_form(params))}
  end

  def handle_event("open", %{ "type" => type } = params, socket) do
    {:noreply, socket
      |> assign(:modal_type, type)
      |> assign(:form, cast_form(params))}
  end

  def handle_event("presentation-changed", _params, socket) do
    {:noreply, assign(socket, :modal_type, nil)}
  end

  defp cast_form(%{ "type" => type, "detents" => detents }) do
    to_form(%{
      "type" => type,
      "detents" => detents == "true"
    })
  end
end
