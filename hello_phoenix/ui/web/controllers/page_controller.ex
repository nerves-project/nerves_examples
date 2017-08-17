defmodule Ui.PageController do
  use Ui.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
