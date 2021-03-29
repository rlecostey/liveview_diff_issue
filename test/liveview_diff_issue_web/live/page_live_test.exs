defmodule LiveviewDiffIssueWeb.PageLiveTest do
  use LiveviewDiffIssueWeb.ConnCase

  import Phoenix.LiveViewTest

  test "it works with leex", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/eex_ok")
    do_scenario(view)
  end

  test "it crashes with slimleex", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/slim_crash")
    do_scenario(view)
  end

  defp do_scenario(view) do
    view |> element("#link-index-1") |> render_click()
  end
end
