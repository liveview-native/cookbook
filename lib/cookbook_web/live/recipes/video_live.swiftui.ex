defmodule CookbookWeb.VideoLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns, interface) do
    dbg interface
    ~LVN"""
    <VideoPlayer
      :interface-target="tvos"
      url={@video}
      autoplay
      style="ignoresSafeArea();"
      phx-change="video-changed"
      phx-debounce={1000}
    >
      <VStack
        style={[
          ~s[animation(.default, value: attr("value"))],
          "frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)",
        ]}
        value={@info || ""}
      >
        <.overlay :if={@info} info={@info} />
      </VStack>
    </VideoPlayer>

    <Group :interface-target="ios">
      <.video video={@video} title={@title} author={@author} info={@info} description={@description} />
    </Group>

    <Group :interface-target="ipados">
      <.video video={@video} title={@title} author={@author} info={@info} description={@description} />
    </Group>

    <Group :interface-target="visionos">
      <.video video={@video} title={@title} author={@author} info={@info} description={@description} />
    </Group>

    <Group :interface-target="macos">
      <.video video={@video} title={@title} author={@author} info={@info} description={@description} />
    </Group>
    """
  end

  defp video(assigns, _interface) do
    ~LVN"""
    <ScrollView>
      <VideoPlayer
        url={@video}
        autoplay
        style={[
          "aspectRatio(1.777, contentMode: .fit)",
          ~s[navigationTitle(attr("title"))],
          ~s[navigationSubtitle(attr("subtitle"))]
        ]}
        title={@title}
        subtitle={@author}
        phx-change="video-changed"
        phx-debounce={1000}
      >
        <VStack
          style={[
            ~s[animation(.default, value: attr("value"))],
            "frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)",
          ]}
          value={@info || ""}
        >
          <.overlay :if={@info} info={@info} />
        </VStack>
      </VideoPlayer>
      <VStack alignment="leading" style="padding();">
        <Text style="font(.headline); bold();"><%= @title %></Text>
        <Text style="font(.subheadline); foregroundStyle(.secondary);"><%= @author %></Text>
        <Divider />
        <Text style=""><%= @description %></Text>
      </VStack>
    </ScrollView>
    """
  end

  attr :info, :any
  def overlay(assigns, _interface) do
    ~LVN"""
    <VStack
      alignment="leading"
      style={[
        "padding()",
        "background(.ultraThinMaterial, in: .rect(cornerRadius: 8))",
        "padding()"
      ]}
    >
      <Label
        style="font(.caption); font(.headline); bold();"
        systemImage="binoculars.fill"
      >
        X-Ray
      </Label>
      <Text style="font(.caption2); foregroundStyle(.secondary);"><%= @info %></Text>
    </VStack>
    """
  end
end
