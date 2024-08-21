defmodule CookbookWeb.PyramidNavigationLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <ScrollView
      style={[
        "contentMargins(16)",
        ~s[fullScreenCover(isPresented: attr("isPresented"), content: :overlay)]
      ]}
      isPresented={@selection != nil}
    >
      <TabView
        template="overlay"
        selection={@selection || 0}
        style={[
          "ignoresSafeArea()",
          "tabViewStyle(.page)",
          "safeAreaInset(edge: .top, content: :title)"
        ]}
        phx-change="select"
      >
        <Rectangle
          style={[
            ~s[fill(Color(hue: attr("hue"), saturation: 0.75, brightness: 0.9))],
            "ignoresSafeArea()"
          ]}
          :for={i <- 1..25}
          hue={i / 25}
          tag={i}
        >
        </Rectangle>
        <HStack template="title" style="padding()">
          <Spacer />
          <.button phx-click="done">
            <Image systemName="xmark" style={[
              "foregroundStyle(.secondary)",
              "bold()",
              "padding(8)",
              "background(.regularMaterial, in: .circle)"
            ]} />
          </.button>
        </HStack>
      </TabView>

      <LazyVGrid
        columns={[%{ size: %{ adaptive: %{ minimum: 100 } } }]}
        style="buttonStyle(.plain)"
      >
        <.button
          :for={i <- 1..25}
          phx-click="select"
          phx-value-selection={i}
        >
          <Rectangle
            style={[
              ~s[fill(Color(hue: attr("hue"), saturation: 0.75, brightness: 0.9))],
              "aspectRatio(1, contentMode: .fit)"
            ]}
            hue={i / 25}
          />
        </.button>
      </LazyVGrid>
    </ScrollView>
    """
  end
end
