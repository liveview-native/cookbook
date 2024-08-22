defmodule CookbookWeb.PlaybackBarLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  # iOS

  def render(assigns, %{ "target" => "ios" } = _interface) do
    ~LVN"""
    <Group
      style={[
        ~s[sheet(isPresented: attr("isPresented"), content: :playback_bar)],
      ]}
      isPresented={true}
    >
      <.song_list />

      <ViewThatFits
        template="playback_bar"
        style={[
          "presentationDetents([.height(70), .large])",
          "presentationDragIndicator(.hidden)",
          "presentationBackgroundInteraction(.enabled)",
          "interactiveDismissDisabled()",
        ]}
      >
        <.expanded_player />
        <HStack style={[
          "padding(8)",
          "background(.bar, in: .rect(cornerRadius: 8))",
          "padding(8)",
          "presentationBackground(.clear)",
        ]}>
          <.collapsed_player />
        </HStack>
      </ViewThatFits>
    </Group>
    """
  end

  # macOS

  def render(assigns, %{ "target" => "macos" } = _interface) do
    ~LVN"""
    <Group style="toolbar(content: :toolbar)">
      <.song_list />
      <ToolbarItem template="toolbar" placement="principal">
        <Group style={[
          "padding(4)",
          "background(.quinary, in: .rect(cornerRadius: 8))",
          "frame(width: 200)"
        ]}>
          <.collapsed_player />
        </Group>
      </ToolbarItem>
    </Group>
    """
  end

  # iPadOS

  def render(assigns, _interface) do
    ~LVN"""
    <Group style="toolbar(content: :toolbar)">
      <.song_list />

      <ToolbarItem template="toolbar" placement="bottomBar">
        <.collapsed_player />
      </ToolbarItem>
    </Group>
    """
  end

  ## Components

  def song_list(assigns) do
    ~LVN"""
    <List
      style={[
        ~s[navigationTitle("Music")],
        "listStyle(.plain)"
      ]}
      isPresented={true}
    >
      <Text :for={i <- 1..50}>
        Song <%= i %>
      </Text>
    </List>
    """
  end

  def expanded_player(assigns) do
    ~LVN"""
    <VStack style={[
      "frame(minHeight: 200)",
      "presentationBackground(.background)",
      "padding()"
    ]}>
      <RoundedRectangle
        cornerRadius={8}
        style={[
          "fill(.blue)",
          "aspectRatio(1, contentMode: .fit)",
          "layoutPriority(1)"
        ]}
      />
      <HStack style={[
        "imageScale(.large)",
        "symbolRenderingMode(.hierarchical)",
        "padding()"
      ]}>
        <VStack alignment="leading">
            <Text style="font(.title3); bold()">Song</Text>
            <Text style="font(.title3); foregroundStyle(.secondary)">Artist</Text>
        </VStack>
        <Spacer />
        <.button><.icon name="star.circle.fill" /></.button>
        <.button><.icon name="ellipsis.circle.fill" /></.button>
      </HStack>
      <ProgressView value={0.5} style="progressViewStyle(.linear); padding(.horizontal);">
        <Text template="currentValueLabel">0:30</Text>
      </ProgressView>
      <HStack style="frame(maxHeight: .infinity); font(.largeTitle)">
        <.button style="frame(maxWidth: .infinity)"><.icon name="backward.fill" /></.button>
        <.button style="frame(maxWidth: .infinity); font(.system(size: 60))"><.icon name="pause.fill" /></.button>
        <.button style="frame(maxWidth: .infinity)"><.icon name="forward.fill" /></.button>
      </HStack>
    </VStack>
    """
  end

  def collapsed_player(assigns) do
    ~LVN"""
    <HStack>
      <RoundedRectangle
        cornerRadius={4}
        style={[
          "fill(.blue)",
          "aspectRatio(1, contentMode: .fit)"
        ]}
      />
      <Text>Song</Text>
      <Spacer />
      <.button style="imageScale(.large)"><.icon name="pause.fill" /></.button>
      <.button><.icon name="forward.fill" /></.button>
    </HStack>
    """
  end
end
