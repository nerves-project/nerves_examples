defmodule UiWeb.UserLiveTest do
  use UiWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ui.AccountsFixtures

  @create_attrs %{age: 42, name: "some name"}
  @update_attrs %{age: 43, name: "some updated name"}
  @invalid_attrs %{age: nil, name: nil}

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  describe "Index" do
    setup [:create_user]

    test "lists all users", %{conn: conn, user: user} do
      {:ok, _index_live, html} = live(conn, Routes.user_index_path(conn, :index))

      assert html =~ "Listing Users"
      assert html =~ user.name
    end

    test "saves new user", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.user_index_path(conn, :index))

      assert index_live |> element("a", "New User") |> render_click() =~
               "New User"

      assert_patch(index_live, Routes.user_index_path(conn, :new))

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user-form", user: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_index_path(conn, :index))

      assert html =~ "User created successfully"
      assert html =~ "some name"
    end

    test "updates user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, Routes.user_index_path(conn, :index))

      assert index_live |> element("#user-#{user.id} a", "Edit") |> render_click() =~
               "Edit User"

      assert_patch(index_live, Routes.user_index_path(conn, :edit, user))

      assert index_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user-form", user: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_index_path(conn, :index))

      assert html =~ "User updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes user in listing", %{conn: conn, user: user} do
      {:ok, index_live, _html} = live(conn, Routes.user_index_path(conn, :index))

      assert index_live |> element("#user-#{user.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user-#{user.id}")
    end
  end

  describe "Show" do
    setup [:create_user]

    test "displays user", %{conn: conn, user: user} do
      {:ok, _show_live, html} = live(conn, Routes.user_show_path(conn, :show, user))

      assert html =~ "Show User"
      assert html =~ user.name
    end

    test "updates user within modal", %{conn: conn, user: user} do
      {:ok, show_live, _html} = live(conn, Routes.user_show_path(conn, :show, user))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User"

      assert_patch(show_live, Routes.user_show_path(conn, :edit, user))

      assert show_live
             |> form("#user-form", user: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#user-form", user: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_show_path(conn, :show, user))

      assert html =~ "User updated successfully"
      assert html =~ "some updated name"
    end
  end
end
