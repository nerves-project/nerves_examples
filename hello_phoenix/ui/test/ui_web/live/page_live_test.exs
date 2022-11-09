defmodule UiWeb.PageLiveTest do
  use UiWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Hello Phoenix Example!"
    assert render(page_live) =~ "Welcome to Hello Phoenix Example!"
  end
end
