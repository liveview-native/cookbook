defmodule CookbookWeb.VideoLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  @info [
    {0, "Details about the video will appear here."},
    {10, "Composer: Jan Morgenstern"},
    {20, "Peach was the codename for Blender's movie project."},
    {25, "Here the title appears, and we're introduced to the main character."},
    {40, "Composer Jan Morgenstern also voiced Big Buck Bunny."},
    {60, "This movie was made in the open source 3D program Blender."},
  ]

  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(:title, "Big Buck Bunny")
      |> assign(:author, "Blender Foundation")
      |> assign(:description, "A day in the life of Big Buck Bunny, during which time he meets three bullying rodents: the leader, Frank the flying squirrel, and his sidekicks Rinky the red squirrel and Gimera the chinchilla.")
      |> assign(:info, nil)
      |> assign(:video, "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")}
  end

  def handle_event("video-changed", %{ "playback-time" => playback_time }, socket) do
    next_info = case @info
      |> Enum.reverse()
      |> Enum.filter(fn {time, _} -> playback_time >= time and time + 6 > playback_time end)
    do
      [ {_, info} | _ ] ->
        info
      _ ->
        nil
    end
    {:noreply, assign(socket, :info, next_info)}
  end
  def handle_event("video-changed", params, socket), do: {:noreply, socket}
end
