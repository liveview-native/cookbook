defmodule CookbookWeb.MediaOverviewLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns, _interface) do
    ~LVN"""
    <List style="listStyle(.plain); ignoresSafeArea(edges: .top); toolbarBackground(.hidden, for: .navigationBar); navigationBarBackButtonHidden(true); toolbar(content: :toolbar)">
      <%!-- back button --%>
      <%!-- TODO: add action to go back on button press --%>
      <ToolbarItem template="toolbar" placement="topBarLeading">
        <.button style="buttonStyle(.bordereless); tint(.primary);">
          <Image
            systemName="chevron.backward"
            style="font(.caption); bold(); frame(width: 28, height: 28); background(.bar, in: .circle);"
          />
        </.button>
      </ToolbarItem>
      <ToolbarItem template="toolbar" placement="topBarTrailing">
        <.button style="buttonStyle(.bordereless); tint(.primary);">
          <Image
            systemName="plus"
            style="font(.caption); bold(); frame(width: 28, height: 28); background(.bar, in: .circle);"
          />
        </.button>
      </ToolbarItem>
      <%!-- cover row --%>
      <VStack
        style="background(content: :background); foregroundStyle(.white); listRowInsets(EdgeInsets());"
      >
        <%!-- album art space --%>
        <Spacer style="aspectRatio(1, contentMode: .fit);" />

        <VStack style="padding(); frame(maxWidth: .infinity); background(content: :background);">
          <%!-- title --%>
          <Text style="font(.title); bold();">Album</Text>
          <Text style="font(.title2);">Artist</Text>
          <Text style="font(.caption); bold(); foregroundStyle(.regularMaterial);">Genre · Year · Metadata</Text>

          <%!-- actions --%>
          <HStack style="padding(.vertical, 8); tint(.white); buttonStyle(.borderedProminent); controlSize(.large);">
            <.button>
              <Label systemImage="play.fill" style="foregroundStyle(.black); bold(); frame(maxWidth: .infinity);">Play</Label>
            </.button>
            <.button>
              <Label systemImage="shuffle" style="foregroundStyle(.black); bold(); frame(maxWidth: .infinity);">Shuffle</Label>
            </.button>
          </HStack>

          <%!-- description --%>
          <Text style="font(.footnote); foregroundStyle(.thickMaterial); lineLimit(2);">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris magna leo, lacinia ut faucibus quis, sodales eget ex. Aenean et metus euismod, luctus nunc at, lobortis nunc.</Text>

          <%!-- background blur --%>
          <Rectangle
            template="background"
            style="fill(.thinMaterial); mask(mask: :mask)"
          >
            <Rectangle
              template="mask"
              style="fill(.linearGradient(colors: [.black.opacity(0), .black], startPoint: .top, endPoint: .bottom))"
            />
          </Rectangle>
        </VStack>

        <%!-- background image --%>
        <Rectangle template="background" style="fill(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)); ignoresSafeArea();" />
      </VStack>

      <%!-- track list --%>
      <.button
        :for={track <- 1..15}
      >
        <Label>
          <Text template="icon" style="foregroundStyle(.secondary)"><%= track %></Text>
          <Text template="title">Track <%= track %></Text>
        </Label>
      </.button>
    </List>
    """
  end
end
