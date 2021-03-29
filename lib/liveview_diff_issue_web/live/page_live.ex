defmodule LiveviewDiffIssueWeb.PageLive do
  alias LiveviewDiffIssueWeb.PageView
  use LiveviewDiffIssueWeb, :live_view

  def mount(_, %{"template" => template}, socket) do
    {
      :ok,
      socket
      |> assign(:active_link_index, 0)
      |> assign(:active_link_medias, [%{id: 1, links: [], name: "media-1"}])
      |> assign(:available_medias, [%{id: 1, links: [0], name: "media-1"}, %{id: 2, links: [], name: "media-2"}])
      |> assign(:link_labels, ["link-1", "link-2"])
      |> assign(:open_media_selection, false)
      |> assign(:selected_media_id, 1)
      |> assign(:template, template)
    }
  end

  def render(assigns) do
    PageView.render(assigns.template, assigns)
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

  defp reload_link_medias(socket, index) do
    Enum.filter(socket.assigns.available_medias, fn media ->
      index in media.links
    end)
  end
end
