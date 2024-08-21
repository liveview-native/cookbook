defmodule CookbookWeb.DrillDownNavigationLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  import LiveViewNative.SwiftUI.Component

  def render(assigns) do
    ~LVN"""
    <List style='navigationTitle(attr("title"))' title={@title}>
      <.link
        :for={i <- 1..10}
        navigate={~p"/recipes/drill-down-navigation?index=#{i}"}
      >
        Item <%= i %>
      </.link>
    </List>
    """
  end
end
