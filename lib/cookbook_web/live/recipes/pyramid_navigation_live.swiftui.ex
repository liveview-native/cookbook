defmodule CookbookWeb.PyramidNavigationLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns, %{ "target" => "macos" } = _interface) do
    ~LVN"""
    <%= if @selection != nil do %>
    <Group>
      <.detail_view selection={@selection} target="macos" />
    </Group>
    <% else %>
    <ScrollView style="contentMargins(16)">
      <.item_grid />
    </ScrollView>
    <% end %>
    """
  end

  def render(assigns, _interface) do
    ~LVN"""
    <ScrollView
      style={[
        "contentMargins(16)",
        ~s[fullScreenCover(isPresented: attr("isPresented"), content: :overlay)]
      ]}
      isPresented={@selection != nil}
    >
      <Group template="overlay">
        <.detail_view selection={@selection} target="ios" />
      </Group>

      <.item_grid />
    </ScrollView>
    """
  end

  def item_grid(assigns) do
    ~LVN"""
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
    """
  end

  attr :selection, :integer
  attr :target, :string
  def detail_view(assigns) do
    ~LVN"""
    <TabView
      selection={@selection || 0}
      style={[
        "ignoresSafeArea()",
        "tabViewStyle(.page)",
        "safeAreaInset(edge: .leading, content: :leading_actions)",
        "safeAreaInset(edge: .trailing, content: :trailing_actions)",
        "safeAreaInset(edge: .top, content: :title)",
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
        <.button phx-click="done" style="buttonStyle(.plain);">
          <Image systemName="xmark" style={[
            "foregroundStyle(.secondary)",
            "bold()",
            "padding(8)",
            "background(.regularMaterial, in: .circle)"
          ]} />
        </.button>
      </HStack>

      <Group template="leading_actions" :if={@target == "macos"}>
        <.button phx-click="previous" style="padding();">
          <.icon name="arrow.left" />
        </.button>
      </Group>
      <Group template="trailing_actions" :if={@target == "macos"}>
        <.button phx-click="next" style="padding();">
          <.icon name="arrow.right" />
        </.button>
      </Group>
    </TabView>
    """
  end
end
