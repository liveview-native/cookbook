defmodule CookbookWeb.MapsLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <Group style="safeAreaInset(edge: .bottom, content: :hint)">
      <Group :interface-target="ios">
        <.map {assigns} />
      </Group>
      <Group :interface-target="ipados">
        <.map {assigns} />
      </Group>
      <Group :interface-target="visionos">
        <.map {assigns} />
      </Group>
      <Group :interface-target="macos">
        <.map {assigns} />
      </Group>

      <ContentUnavailableView :interface-target="tvos">
        <Label systemImage="mappin.slash.circle.fill">MapKit is not available for tvOS</Label>
      </ContentUnavailableView>

      <Group :interface-target="ios" template="hint">
        <.look_around />
      </Group>
      <Group :interface-target="ipados" template="hint">
        <.look_around />
      </Group>
    </Group>
    """
  end

  defp map(assigns) do
    ~LVN"""
    <Map
      style={[
        ~s[navigationTitle("Maps")],
        ~s/lookAroundViewer(isPresented: attr("is-presented"), initialScene: CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242))/
      ]}
      is-presented={@look_around?}
    >
      <Marker
        :for={%{ name: name, coordinate: [latitude, longitude], icon: icon } <- @places}
        latitude={latitude}
        longitude={longitude}
        system-image={icon}
      >
        <%= name %>
      </Marker>
    </Map>
    """
  end

  defp look_around(assigns) do
    ~LVN"""
    <.button
      phx-click="look-around"
      style={[
        "buttonStyle(.borderedProminent)",
        "controlSize(.extraLarge)",
        "padding()"
      ]}
    >
      <Label
        systemImage="binoculars.fill"
        style="frame(maxWidth: .infinity);"
      >
        Look Around
      </Label>
    </.button>
    """
  end
end
