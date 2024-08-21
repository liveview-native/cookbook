defmodule CookbookWeb.SectionedGridLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H""
  end
end
