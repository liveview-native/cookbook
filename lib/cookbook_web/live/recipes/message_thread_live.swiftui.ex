defmodule CookbookWeb.MessageThreadLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <ScrollView
      style={[
        "defaultScrollAnchor(.bottom)",
        ~s[navigationTitle("Messages")],
        "safeAreaPadding(.leading)",
        "safeAreaInset(edge: .bottom, content: :bottom_bar)",
      ]}
    >
      <VStack template="bottom_bar" spacing="0">
        <Divider />
        <HStack style="padding(8); background(.bar)">
          <TextField style={[
            "textFieldStyle(.plain)",
            "padding(.vertical, 6)",
            "padding(.leading, 10)",
            "padding(.trailing, 32)",
            "overlay(alignment: .trailing, content: :overlay)",
            "background(content: :background)",
          ]}>
            Message
            <Capsule template="background" style="stroke(.quaternary)" />
            <Button template="overlay" style="buttonStyle(.borderless)">
              <Image systemName="arrow.up.circle.fill" style="font(.title)" />
            </Button>
          </TextField>
        </HStack>
      </VStack>
      <LazyVStack alignment="leading" style="frame(maxWidth: .infinity, alignment: .leading)">
        <Text
          :for={i <- 1..300}
          style={[
            "padding(.vertical, 8)",
            "padding(.horizontal)",
            "background(.quinary, in: .capsule)"
          ]}
        >
          Message <%= i %>
        </Text>
      </LazyVStack>
    </ScrollView>
    """
  end
end
