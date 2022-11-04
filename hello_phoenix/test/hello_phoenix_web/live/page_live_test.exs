defmodule HelloPhoenixWeb.PageLiveTest do
  use HelloPhoenixWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome"
    assert disconnected_html =~ "Phoenix Framework on Nerves"
    assert render(page_live) =~ "Welcome to Hello Phoenix Example!"
  end
end
