defmodule CookbookWeb.ModalsLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <Group style='background(content: :modals); navigationTitle("Modals");'>
      <.simple_form for={@form} id="type" phx-submit="open">
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
          <Text template="content">Sheet content</Text>
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
