defmodule UiWeb.PageController do
  use UiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
