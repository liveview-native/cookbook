defmodule CookbookWeb.SectionedGridLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
      <ScrollView style={[
        "defaultScrollAnchor(.bottom)"
      ]}>
        <LazyVGrid columns={[%{ size: %{ adaptive: %{ minimum: 80 } }, spacing: 0 }]} spacing={0} pinnedViews="sectionHeaders">
          <Section
            :for={section <- 1..10}
          >
            <Text
              template="header"
              style={[
                "padding(8)",
                "background(.regularMaterial, in: .rect(cornerRadius: 8))",
                "padding()",
                "frame(maxWidth: .infinity, alignment: .leading)",
                "offset(y: 32)",
                "frame(height: 0)",
              ]}
            >
              Section <%= section %>
            </Text>
            <Rectangle
              :for={i <- 1..40}
              style={[
                ~s[foregroundStyle(Color(hue: attr("hue"), saturation: 1, brightness: 1))],
                "aspectRatio(1, contentMode: .fill)"
              ]}
              hue={rem(i, 30) / 30}
            />
          </Section>
        </LazyVGrid>
      </ScrollView>
    """
  end
end
