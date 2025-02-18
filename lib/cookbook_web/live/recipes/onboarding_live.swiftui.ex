defmodule CookbookWeb.OnboardingLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <VStack style="padding();" spacing={32}>
      <Text style="font(.largeTitle); bold();">What's New</Text>
      <Grid alignment="leading" horizontalSpacing={16} verticalSpacing={16}>
        <.feature
          name="Onboarding"
          icon="wand.and.sparkles"
          description="See how to make a system-styled What's New screen."
        />
        <.feature
          name="Maps"
          icon="mappin.and.ellipse"
          description="Use the MapKit addon to create interactive maps."
          style="foregroundStyle(.red);"
        />
        <.feature
          name="Charts"
          icon="chart.line.uptrend.xyaxis"
          description="Plot data on various charts with the Swift Charts addon"
          style="foregroundStyle(.purple);"
        />
      </Grid>
      <Spacer />
      <Button style="buttonStyle(.borderedProminent); controlSize(.large);">
        <Text style="frame(maxWidth: .infinity);">Continue</Text>
      </Button>
    </VStack>
    """
  end

  attr :icon, :string
  attr :name, :string
  attr :description, :string
  attr :rest, :global

  def feature(assigns, _interface) do
    ~LVN"""
    <GridRow>
      <Group style="foregroundStyle(.tint); font(.largeTitle); symbolRenderingMode(.hierarchical);">
        <Image
          systemName={@icon}
          {@rest}
        />
      </Group>
      <VStack alignment="leading" style="font(.subheadline);">
        <Text style="bold();"><%= @name %></Text>
        <Text style="foregroundStyle(.secondary);"><%= @description %></Text>
      </VStack>
    </GridRow>
    """
  end
end
