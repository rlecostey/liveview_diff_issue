defmodule LiveviewDiffIssueWeb.PageLiveTest do
  use LiveviewDiffIssueWeb.ConnCase

  import Phoenix.LiveViewTest

  test "liveview diff issue test", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")

    view
    |> element(".add-media-btn")
    |> render_click()

    view
    |> element("#media-form")
    |> render_change(%{"medias" => "1"})

    view
    |> element(".submit-media-btn")
    |> render_click()

    Process.sleep(2000)

    view
    |> element("#link-index-1")
    |> render_click()
  end
end
