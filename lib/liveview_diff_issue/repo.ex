defmodule LiveviewDiffIssue.Repo do
  use Ecto.Repo,
    otp_app: :liveview_diff_issue,
    adapter: Ecto.Adapters.Postgres
end
