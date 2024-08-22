defmodule CookbookWeb.MapsLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns, %{ "target" => target } = _interface) do
    assigns = assign(assigns, :target, target)
    ~LVN"""
    <Map
      style={[
        ~s[navigationTitle("Maps")],
        "safeAreaInset(edge: .bottom, content: :hint)",
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
      <.button
        template="hint"
        :if={@target == "ios" or @target == "ipados"}
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
    </Map>
    """
  end
end
