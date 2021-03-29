defmodule LiveviewDiffIssueWeb.Router do
  use LiveviewDiffIssueWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LiveviewDiffIssueWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", LiveviewDiffIssueWeb do
    pipe_through :browser

    live "/eex_ok", PageLive, :index, session: %{"template" => "eex_ok.html"}
    live "/slim_crash", PageLive, :index, session: %{"template" => "slim_crash.html"}
  end

end
