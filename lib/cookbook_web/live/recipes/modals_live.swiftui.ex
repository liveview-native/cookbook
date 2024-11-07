defmodule CookbookWeb.ModalsLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <Group style='background(content: :modals); navigationTitle("Modals");'>
      <.simple_form for={@form} id="type" phx-submit="open" phx-change="form-changed">
        <.input
          type="Picker"
          field={@form[:type]}
          options={[
            {"Sheet", "sheet"},
            {"Full Screen Cover", "fullScreenCover"},
            {"Popover", "popover"},
            {"Alert", "alert"},
            {"Confirmation Dialog", "confirmationDialog"},
            {"Inspector", "inspector"},
          ]}
          label="Modal Type"
        />
        <Section :if={@form[:type].value == "sheet"}>
          <Text template="header">Sheet Customization</Text>
          <.input
            type="Toggle"
            field={@form[:detents]}
            label="Detents"
          />
          <.input
            type="Toggle"
            field={@form[:drag_indicator]}
            label="Drag Indicator"
          />
          <.input
            type="Picker"
            field={@form[:background]}
            options={[
              {"Unspecified", ""},
              {"Red", "system-red"},
              {"Green", "system-green"},
              {"Blue", "system-blue"}
            ]}
            label="Background"
          />
          <.input
            type="Picker"
            field={@form[:corner_radius]}
            options={[
              {"Unspecified", ""},
              {"None", "0"},
              {"Medium", "50"},
              {"Large", "100"}
            ]}
            label="Corner Radius"
          />
        </Section>
        <%!-- the popover is attached to the "Open" button --%>
        <Group
          style='popover(isPresented: attr("presented"), content: :content);'
          presented={@modal_type == "popover"}
          phx-change="presentation-changed"
        >
          <.button type="submit">Open</.button>

          <%!-- `presentationCompactAdaptation` forces a popover to be used on smaller devices --%>
          <VStack template="content" style="padding(); presentationCompactAdaptation(horizontal: .popover, vertical: .popover);">
            <Text>Popover content</Text>
          </VStack>
        </Group>
      </.simple_form>

      <Group template="modals">
        <VStack
          style='sheet(isPresented: attr("presented"), content: :content);'
          presented={@modal_type == "sheet"}
          phx-change="presentation-changed"
        >
          <Group
            template="content"
          >
            Sheet content
            <VStack :if={@form[:detents].value} style="presentationDetents([.medium, .large]);"></VStack>
            <VStack style='presentationDragIndicator(attr("visibility"));' visibility={if @form[:drag_indicator].value, do: "visible", else: "hidden"}></VStack>
            <VStack :if={@form[:background].value != ""} style='presentationBackground(attr("background"));' background={@form[:background].value}></VStack>
            <VStack :if={@form[:corner_radius].value != ""} style='presentationCornerRadius(attr("radius"));' radius={@form[:corner_radius].value}></VStack>
          </Group>
        </VStack>

        <VStack
          style='fullScreenCover(isPresented: attr("presented"), content: :content);'
          presented={@modal_type == "fullScreenCover"}
          phx-change="presentation-changed"
        >
          <VStack template="content">
            <Text>Full screen cover content</Text>
            <.button phx-click="presentation-changed">Dismiss</.button>
          </VStack>
        </VStack>

        <VStack
          style='alert("Alert Title", isPresented: attr("presented"), actions: :actions, message: :message);'
          presented={@modal_type == "alert"}
          phx-change="presentation-changed"
        >
          <Text template="message">Alert message content</Text>

          <Button role="cancel" template="actions">
            Cancel
          </Button>
          <Button role="destructive" template="actions">
            Delete
          </Button>
        </VStack>

        <VStack
          style='confirmationDialog("Confirmation Dialog Title", isPresented: attr("presented"), titleVisibility: .visible, actions: :actions);'
          presented={@modal_type == "confirmationDialog"}
          phx-change="presentation-changed"
        >
          <Button role="cancel" template="actions">
            Cancel
          </Button>
          <Button role="destructive" template="actions">
            Delete
          </Button>
        </VStack>

        <VStack
          style='inspector(isPresented: attr("presented"), content: :content);'
          presented={@modal_type == "inspector"}
          phx-change="presentation-changed"
        >
          <Text template="content">Inspector content</Text>
        </VStack>
      </Group>
    </Group>
    """
  end
end
