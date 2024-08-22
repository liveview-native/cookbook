defmodule CookbookWeb.CardRowLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns, interface) do
    target = Map.get(interface, "target", "ios")
    assigns = assign(assigns, :target, target)
    ~LVN"""
    <ScrollView style='navigationTitle("Card Row")'>
      <ScrollView
        axes="horizontal"
        style={[
          "scrollTargetBehavior(.viewAligned)",
          "safeAreaPadding(.horizontal, 32)",
          "scrollIndicators(.hidden)"
        ]}
      >
        <LazyHStack style="padding(.top); scrollTargetLayout()">
          <VStack
            :for={{hint, i} <- Enum.with_index([
              "The ScrollView uses `scrollTargetBehavior(.viewAligned)` to snap to each card",
              "The `safeAreaPadding` modifier is used to inset the content of each card",
              "The `scrollTargetLayout` modifier is applied to the `LazyHStack` in the `ScrollView`, enabling its child cards to be snapped to.",
              "Each card uses the `containerRelativeFrame` modifier to fill the screen width",
              "The `aspectRatio` modifier limits the card to a 16:9 shape",
            ])}
            alignment="leading"
          >
            <Text style={[
              "font(.caption)",
              "fontWeight(.bold)",
              "foregroundStyle(.secondary)",
              "textCase(.uppercase)"
            ]}>
              Hint
            </Text>
            <Text style="font(.title3)">Step <%= i + 1 %></Text>
            <Rectangle
              style={[
                ~s[foregroundStyle(Color(hue: attr("hue"), saturation: 1, brightness: 1))],
                "aspectRatio(1.777, contentMode: .fill)",
                ~s[containerRelativeFrame(.horizontal, count: attr("count"), span: 1, spacing: 8)],
                "overlay(alignment: .bottomLeading, content: :description)",
                "clipShape(.rect(cornerRadius: 8, style: .continuous))"
              ]}
              hue={i / 10}
              count={if @target == "ios", do: 1, else: 3}
            >
              <Text template="description" style="font(.caption); foregroundStyle(.white); multilineTextAlignment(.leading); frame(maxWidth: .infinity, alignment: .leading); padding(8); background(.linearGradient(colors: [.black.opacity(0), .black.opacity(0.5)], startPoint: .top, endPoint: .bottom))">
                <%= hint %>
              </Text>
            </Rectangle>
          </VStack>
        </LazyHStack>
      </ScrollView>
    </ScrollView>
    """
  end
end
