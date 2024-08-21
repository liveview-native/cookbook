defmodule CookbookWeb.TabsLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <TabView selection={@tab} phx-change="tab-changed">
      <VStack tag="1" style="tabItem(:item)">
        <Label
          template="item"
          systemImage="1.circle.fill"
        >
          Tab 1
        </Label>

        Tab 1 Content
      </VStack>
      <VStack tag="2" style="tabItem(:item)">
        <Label
          template="item"
          systemImage="2.circle.fill"
        >
          Tab 2
        </Label>

        Tab 2 Content
      </VStack>
    </TabView>
    """
  end
end
