defmodule LiveviewDiffIssueWeb.PageLive do
  alias LiveviewDiffIssueWeb.PageView
  use LiveviewDiffIssueWeb, :live_view

  @available_medias [
    %{id: 1, name: "media-1", links: []},
    %{id: 2, name: "media-2", links: []}
  ]

  def mount(_, _, socket) do
    socket =
      socket
      |> assign(:active_link_index, 0)
      |> assign(:active_link_medias, [])
      |> assign(:link_labels, ["link-1", "link-2"])
      |> assign(:available_medias, @available_medias)
      |> assign(:open_media_selection, false)

    {:ok, socket}
  end

  def render(assigns) do
    PageView.render("liveview_issue_2.html", assigns)
  end

  def handle_event("select_link", %{"value" => value}, socket) do
    active_link_index = value |> String.split("link-") |> List.last() |> String.to_integer()
    link_medias = reload_link_medias(socket, active_link_index)

    {:noreply,
     socket
     |> assign(:active_link_index, active_link_index)
     |> assign(:active_link_medias, link_medias)
     |> assign(:open_media_selection, false)
     |> assign(:selected_media_id, nil)}
  end

  def handle_event("open_media_selection", _, socket) do
    {:noreply, assign(socket, :open_media_selection, true)}
  end

  def handle_event("select_media", %{"medias" => media_id}, socket) do
    {:noreply, assign(socket, :selected_media_id, String.to_integer(media_id))}
  end

  def handle_event("add_media", _, socket) do
    media = get_media(socket)
    available_medias = update_available_medias(socket, media.id)

    {:noreply,
     socket
     |> assign(:available_medias, available_medias)
     |> assign(:active_link_medias, [media])
     |> assign(:selected_media_id, media.id)
     |> assign(:open_media_selection, false)}
  end

  def handle_info({:add_media_success, media}, socket) do
    available_medias = update_available_medias(socket, media.id)

    {:noreply,
     socket
     |> assign(:available_medias, available_medias)
     |> assign(:active_link_medias, [media])
     |> assign(:selected_media_id, media.id)
     |> assign(:open_media_selection, false)}
  end

  defp update_available_medias(socket, media_id) do
    Enum.map(socket.assigns.available_medias, fn media ->
      if media.id == media_id do
        associate_media(socket, media)
      else
        media
      end
    end)
  end

  defp associate_media(socket, media) do
    Map.update!(media, :links, fn link_ids ->
      link_ids ++ [socket.assigns.active_link_index]
    end)
  end

  defp get_media(socket) do
    Enum.find(socket.assigns.available_medias, &(&1.id == socket.assigns.selected_media_id))
  end

  defp reload_link_medias(socket, index) do
    Enum.filter(socket.assigns.available_medias, fn media ->
      index in media.links
    end)
  end
end
