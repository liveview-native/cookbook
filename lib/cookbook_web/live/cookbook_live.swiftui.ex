defmodule CookbookWeb.CookbookLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns, interface) do
    target = Map.get(interface, "target", "ios")
    assigns = assign(assigns, :target, target)
    ~LVN"""
    <List
      id="cookbook"
      style={[
        "listStyle(.plain)",
        ~s[navigationTitle("Cookbook")],
        "toolbar(content: :toolbar)"
      ]}
    >
      <ToolbarItem template="toolbar">
        <.link href="https://github.com/liveview-native/cookbook" style="buttonStyle(.automatic);">
          <.icon name="info.circle" />
        </.link>
      </ToolbarItem>
      <Section style="listSectionSeparator(.hidden); listSectionSpacing(0);">
        <ScrollView
          axes="horizontal"
          style={[
            "scrollTargetBehavior(.viewAligned)",
            "scrollIndicators(.hidden)",
            "safeAreaPadding(.horizontal, 16)",
            "listRowInsets(EdgeInsets())",
            "listRowSpacing(0)",
            "listRowBackground(:none)",
            "padding(.vertical, 8)"
          ]}
        >
          <HStack style="scrollTargetLayout();">
            <Group
              style={[
                ~s[containerRelativeFrame(.horizontal, count: attr("count"), span: 1, spacing: 16)]
              ]}
              count={if @target == "ios", do: 1, else: 3}
            >
              <.featured_recipe
                :for={{recipe, index} <- Enum.with_index(@featured_recipes)}
                recipe={recipe}
                hue={index / length(@featured_recipes)}
              />
            </Group>
          </HStack>
        </ScrollView>
      </Section>
      <Section>
        <HStack template="header">
          <Text>Recipes</Text>
          <Spacer />
          <Menu>
            <Label template="label" systemImage={if @selected_category == nil, do: "line.3.horizontal.decrease.circle", else: "line.3.horizontal.decrease.circle.fill"}>
              <%= @selected_category || "All" %>
            </Label>

            <Button phx-click="clear-filter">All</Button>
            <Button
              :for={category <- @categories}
              phx-click="filter"
              phx-value-category={category}
            >
              <%= category %>
            </Button>
          </Menu>
        </HStack>
        <.link
          :for={recipe <- @recipes}
          navigate={recipe.path}
        >
          <ProgressView
            template="destination"
            style='navigationTitle(attr("title"))'
            title={recipe.metadata.title}
          />
          <Label>
            <VStack alignment="leading" template="title">
              <Text><%= recipe.metadata.title %></Text>
              <Text style="foregroundStyle(.secondary);"><%= recipe.metadata.description %></Text>
            </VStack>
            <Image template="icon" systemName={recipe.metadata.icon} />
          </Label>
        </.link>
      </Section>
    </List>
    """
  end

  attr :recipe, :any
  attr :hue, :float
  def featured_recipe(assigns, _interface) do
    ~LVN"""
    <.link navigate={@recipe.path} style="buttonStyle(.plain);">
      <VStack
        alignment="leading"
        style={[
          "padding()",
          ~s[background(Color(hue: attr("hue"), saturation: 0.75, brightness: 0.85), in: .rect(cornerRadius: 10, style: .continuous))],
          "foregroundStyle(.white)",
          "aspectRatio(1.777, contentMode: .fill)",
        ]}
        hue={@hue}
      >
        <.icon
          name={@recipe.metadata.icon}
          style={[
            "resizable()",
            "symbolRenderingMode(.hierarchical)",
            "scaledToFit()",
            "padding(10)",
            "frame(maxWidth: 130, maxHeight: 130)",
            "frame(maxWidth: .infinity, maxHeight: .infinity)",
          ]}
        />
        <VStack alignment="leading">
          <Text style="font(.title3); bold();">
            <%= @recipe.metadata.title %>
          </Text>
          <Text style="font(.caption); foregroundStyle(.white.secondary); lineLimit(1);">
            <%= @recipe.metadata.description %>
          </Text>
        </VStack>
      </VStack>
    </.link>
    """
  end
end
