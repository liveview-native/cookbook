defmodule CookbookWeb.HubAndSpokeNavigationLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  import CookbookWeb.CoreComponents.SwiftUI

  def render(assigns) do
    ~LVN"""
    <ScrollView
      style={[
        "contentMargins(16)",
        ~s[fullScreenCover(isPresented: attr("isPresented"), content: :overlay)]
      ]}
      isPresented={@selection != nil}
    >
      <VStack template="overlay" style={[
        "frame(maxWidth: .infinity, maxHeight: .infinity)",
        "safeAreaInset(edge: .top, content: :title)"
      ]}>
        <HStack template="title" style="padding()">
          <Text style={[
            "font(.headline)",
            "bold()"
          ]}>
            Project <%= @selection %>
          </Text>
          <Spacer />
          <.button phx-click="done">Done</.button>
        </HStack>
        Content goes here
      </VStack>

      <LazyVGrid
        columns={[%{ size: %{ adaptive: %{ minimum: 150 } } }]}
        style="buttonStyle(.borderedProminent)"
      >
        <Group
          :for={i <- 1..10}
          style='tint(Color(hue: attr("hue"), saturation: 0.75, brightness: 0.9))'
          hue={i / 10}
        >
          <.button
            phx-click="select"
            phx-value-index={i}
          >
            <VStack
              alignment="leading"
              style={[
                "padding(8)",
                "frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)",
                "font(.title3)",
                "fontWeight(.bold)",
                "aspectRatio(1.5, contentMode: .fit)",
              ]}
            >
              <Image systemName="square.on.square" />
              <Spacer />
              <Text>Project <%= i %></Text>
            </VStack>
          </.button>
        </Group>
      </LazyVGrid>
    </ScrollView>
    """
  end
end
