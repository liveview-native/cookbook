defmodule CookbookWeb.FileUploadLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  import LiveViewNative.SwiftUI.Component

  def render(assigns) do
    ~LVN"""
    <Form style='navigationTitle("File Upload");' :interface-target="ios">
      <.upload_form uploads={@uploads} show_file_picker={@show_file_picker} />
      <.upload_entries uploads={@uploads} />
      <Section>
        <.latest_uploads uploaded_files={@uploaded_files} />
      </Section>
    </Form>

    <Form style='padding(); navigationTitle("File Upload");' :interface-target="macos">
      <.upload_form uploads={@uploads} show_file_picker={@show_file_picker} />
      <.upload_entries uploads={@uploads} />
      <.latest_uploads uploaded_files={@uploaded_files} />
    </Form>

    <Form style='navigationTitle("File Upload");' :interface-target="visionos">
      <.upload_form uploads={@uploads} show_file_picker={@show_file_picker} />
      <.upload_entries uploads={@uploads} />
      <.latest_uploads uploaded_files={@uploaded_files} />
    </Form>

    <ContentUnavailableView style='navigationTitle("File Upload");' :interface-target="tvos">
      <Label systemImage="xmark.bin.fill">File uploads are not available for tvOS</Label>
    </ContentUnavailableView>

    <ContentUnavailableView style='navigationTitle("File Upload");' :interface-target="watchos">
      <Label systemImage="xmark.bin.fill">File uploads are not available for watchOS</Label>
    </ContentUnavailableView>
    """
  end

  defp upload_form(assigns, _interface) do
    ~LVN"""
    <LiveForm id="upload-form" phx-submit="save" phx-change="validate">
      <.button phx-click="toggle-file-picker" style="background(content: :importer);">
        <Label systemImage="folder">
          Choose File...
        </Label>
        <Group template="importer">
          <.live_file_input upload={@uploads.avatar} :if={@show_file_picker} />
        </Group>
      </.button>
      <.button type="submit">
        <HStack>
          <Image systemName="arrow.up.square.fill" />
          Upload
        </HStack>
      </.button>
    </LiveForm>
    """
  end

  defp upload_entries(assigns, _interface) do
    ~LVN"""
    <%!-- use phx-drop-target with the upload ref to enable file drag and drop --%>
    <Section phx-drop-target={@uploads.avatar.ref}>
      <Text template="header" :if={not Enum.empty?(@uploads.avatar.entries)}>Queued Uploads</Text>

      <%!-- render each avatar entry --%>
      <%= for entry <- @uploads.avatar.entries do %>
        <VStack
          alignment="leading"
          style="swipeActions(content: :swipe_actions); listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8));"
        >
          <.live_img_preview entry={entry} style="resizable(); scaledToFit(); clipShape(.rect(cornerRadius: 4));" />

          <%!-- entry.progress will update automatically for in-flight entries --%>
          <ProgressView value={entry.progress} total="100">
            <%= entry.client_name %>
            <Text template="currentValueLabel"><%= entry.progress%>%</Text>
          </ProgressView>

          <%!-- Phoenix.Component.upload_errors/2 returns a list of error atoms --%>
          <%= for err <- upload_errors(@uploads.avatar, entry) do %>
            <Text style="foregroundStyle(.red); bold();"><%= error_to_string(err) %></Text>
          <% end %>

          <%!-- a regular click event whose handler will invoke Phoenix.LiveView.cancel_upload/3 --%>
          <.button
            template="swipe_actions"
            role="destructive"
            phx-click="cancel-upload"
            phx-value-ref={entry.ref}
          >
            <Image systemName="trash" />
          </.button>
        </VStack>
      <% end %>

      <%!-- Phoenix.Component.upload_errors/1 returns a list of error atoms --%>
      <%= for err <- upload_errors(@uploads.avatar) do %>
        <Text style="foregroundStyle(.red); bold();"><%= error_to_string(err) %></Text>
      <% end %>

    </Section>
    """
  end

  defp latest_uploads(assigns, _interface) do
    ~LVN"""
    <Section>
      <Text template="header">Latest Upload</Text>
      <Text id={file} :for={file <- @uploaded_files}>
        <%= file %>
      </Text>
    </Section>
    """
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
end
