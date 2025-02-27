defmodule CookbookWeb.ScrollAutomationLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns, _interface) do
    ~LVN"""
    <%!-- use the `scrollPosition` modifier to scroll to a specific ID --%>
    <ScrollView
      axes="vertical"
      style='safeAreaPadding(); scrollPosition(attr("scroll-position"), anchor: .top); animation(.snappy, value: attr("scroll-position")); background(.linearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)); preferredColorScheme(.light);'
      scroll-position={if @user_interacted, do: "", else: "line-#{@scroll_position}"}
      phx-change="scroll-position-changed"
    >
      <VStack
        alignment="leading"
        style='font(.largeTitle); bold(); animation(.snappy, value: attr("scroll-position")); frame(maxWidth: .infinity, alignment: .leading);'
        scroll-position={@scroll_position}
      >
        <Button
          :for={{lyric, index} <- Enum.with_index(@lyrics)}
          id={"line-#{index}"}
          style='blur(radius: attr("blur")); opacity(attr("opacity")); foregroundStyle(.ultraThickMaterial); padding(.vertical, attr("padding"))'
          padding={if @scroll_position == index, do: 64, else: 16}
          opacity={if @scroll_position == index, do: 1, else: 0.3}
          blur={if @user_interacted, do: 0, else: abs(index - @scroll_position)}
          phx-click="jump"
          phx-value-line={index}
        >
          <%= lyric %>
        </Button>
      </VStack>
    </ScrollView>
    """
  end
end
