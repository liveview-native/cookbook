defmodule CookbookWeb.FileUploadLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  import LiveViewNative.SwiftUI.Component

  def render(assigns) do
    ~LVN"""
    <Form style='navigationTitle("File Upload");'>
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

      <Section>
        <Text template="header">Latest Upload</Text>
        <Text id={file} :for={file <- @uploaded_files}>
          <%= file %>
        </Text>
      </Section>
    </Form>
    """
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  defp error_to_string(:too_many_files), do: "You have selected too many files"

  @doc """
  Builds a file input tag for a LiveView upload.

  [INSERT LVATTRDOCS]

  ## Drag and Drop

  Drag and drop is supported by annotating the droppable container with a `phx-drop-target`
  attribute pointing to the UploadConfig `ref`, so the following markup is all that is required
  for drag and drop support:

  ```heex
  <div class="container" phx-drop-target={@uploads.avatar.ref}>
    <!-- ... -->
    <.live_file_input upload={@uploads.avatar} />
  </div>
  ```

  ## Examples

  Rendering a file input:

  ```heex
  <.live_file_input upload={@uploads.avatar} />
  ```

  Rendering a file input with a label:

  ```heex
  <label for={@uploads.avatar.ref}>Avatar</label>
  <.live_file_input upload={@uploads.avatar} />
  ```
  """
  @doc type: :component

  attr :upload, Phoenix.LiveView.UploadConfig,
    required: true,
    doc: "The `Phoenix.LiveView.UploadConfig` struct"

  attr :accept, :string,
    doc:
      "the optional override for the accept attribute. Defaults to :accept specified by allow_upload"

  attr :rest, :global, include: ~w(webkitdirectory required disabled capture form)

  def live_file_input(%{upload: upload} = assigns) do
    assigns = assign_new(assigns, :accept, fn -> upload.accept != :any && upload.accept end)

    ~LVN"""
    <VStack
      style='fileImporter(id: attr("id"), name: attr("name"), isPresented: attr("is-presented"), allowedContentTypes: attr("accept"), allowsMultipleSelection: attr("multiple"))'
      is-presented
      id={@upload.ref}
      name={@upload.name}
      accept={@accept}
      data-phx-update="ignore"
      data-phx-upload-ref={@upload.ref}
      data-phx-active-refs={join_refs(for(entry <- @upload.entries, do: entry.ref))}
      data-phx-done-refs={join_refs(for(entry <- @upload.entries, entry.done?, do: entry.ref))}
      data-phx-preflighted-refs={join_refs(for(entry <- @upload.entries, entry.preflighted?, do: entry.ref))}
      data-phx-auto-upload={@upload.auto_upload?}
      {if @upload.max_entries > 1, do: Map.put(@rest, :multiple, true), else: @rest}
    />
    """
  end

  defp join_refs(entries), do: Enum.join(entries, ",")

  @doc ~S"""
  Generates an image preview on the client for a selected file.

  [INSERT LVATTRDOCS]

  ## Examples

  ```heex
  <%= for entry <- @uploads.avatar.entries do %>
    <.live_img_preview entry={entry} width="75" />
  <% end %>
  ```

  When you need to use it multiple times, make sure that they have distinct ids

  ```heex
  <%= for entry <- @uploads.avatar.entries do %>
    <.live_img_preview entry={entry} width="75" />
  <% end %>

  <%= for entry <- @uploads.avatar.entries do %>
    <.live_img_preview id={"modal-#{entry.ref}"} entry={entry} width="500" />
  <% end %>
  ```
  """
  @doc type: :component

  attr :entry, Phoenix.LiveView.UploadEntry,
    required: true,
    doc: "The `Phoenix.LiveView.UploadEntry` struct"

  attr :id, :string,
    default: nil,
    doc:
      "the id of the img tag. Derived by default from the entry ref, but can be overridden as needed if you need to render a preview of the same entry multiple times on the same page"

  attr :rest, :global, []

  def live_img_preview(assigns) do
    ~LVN"""
    <Image
      id={@id || "phx-preview-#{@entry.ref}"}
      data-phx-upload-ref={@entry.upload_ref}
      data-phx-entry-ref={@entry.ref}
      data-phx-update="ignore"
      {@rest}
    />
    """
  end
end
