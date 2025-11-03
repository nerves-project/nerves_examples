defmodule HelloLiveViewWeb.PageController do
  use HelloLiveViewWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
