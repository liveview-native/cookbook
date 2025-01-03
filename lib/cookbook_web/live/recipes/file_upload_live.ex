defmodule CookbookWeb.FileUploadLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(:uploaded_files, ["No files uploaded..."])
      |> allow_upload(:avatar, accept: ~w(.png .jpg .jpeg), max_entries: 2)
      |> assign(:show_file_picker, false)}
  end

  def render(assigns) do
    ~H""
  end

  def handle_event("toggle-file-picker", _params, socket) do
    {:noreply, assign(socket, :show_file_picker, not socket.assigns.show_file_picker)}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", params, socket) do
    {:noreply, assign(socket, :show_file_picker, false)}
  end

  @impl Phoenix.LiveView
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :avatar, ref)}
  end

  @impl Phoenix.LiveView
  def handle_event("save", _params, socket) do
    Process.send_after(self(), :tick, 10)
    uploaded_files =
      consume_uploaded_entries(socket, :avatar, fn %{path: path}, entry ->
        dbg entry
        {:ok, Path.basename(path)}
      end)

    {:noreply,
      socket
        |> update(:uploaded_files, &(&1 ++ uploaded_files))
    }
  end

  def handle_info(:tick, socket) do
    {:noreply, assign(
      socket,
      :uploaded_files,
      (if length(socket.assigns.uploaded_files) == 1,
        do: socket.assigns.uploaded_files,
        else: tl(socket.assigns.uploaded_files))
    )}
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
end
