defmodule PhoenixFrameworkWeb.SpaceLiveTest do
  use PhoenixFrameworkWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixFramework.WorldsFixtures

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  defp create_space(_) do
    space = space_fixture()
    %{space: space}
  end

  describe "Index" do
    setup [:create_space]

    test "lists all spaces", %{conn: conn, space: space} do
      {:ok, _index_live, html} = live(conn, ~p"/spaces")

      assert html =~ "Listing Spaces"
      assert html =~ space.description
    end

    test "saves new space", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/spaces")

      assert index_live |> element("a", "New Space") |> render_click() =~
               "New Space"

      assert_patch(index_live, ~p"/spaces/new")

      assert index_live
             |> form("#space-form", space: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#space-form", space: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/spaces")

      html = render(index_live)
      assert html =~ "Space created successfully"
      assert html =~ "some description"
    end

    test "updates space in listing", %{conn: conn, space: space} do
      {:ok, index_live, _html} = live(conn, ~p"/spaces")

      assert index_live |> element("#spaces-#{space.id} a", "Edit") |> render_click() =~
               "Edit Space"

      assert_patch(index_live, ~p"/spaces/#{space}/edit")

      assert index_live
             |> form("#space-form", space: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#space-form", space: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/spaces")

      html = render(index_live)
      assert html =~ "Space updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes space in listing", %{conn: conn, space: space} do
      {:ok, index_live, _html} = live(conn, ~p"/spaces")

      assert index_live |> element("#spaces-#{space.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#spaces-#{space.id}")
    end
  end

  describe "Show" do
    setup [:create_space]

    test "displays space", %{conn: conn, space: space} do
      {:ok, _show_live, html} = live(conn, ~p"/spaces/#{space}")

      assert html =~ "Show Space"
      assert html =~ space.description
    end

    test "updates space within modal", %{conn: conn, space: space} do
      {:ok, show_live, _html} = live(conn, ~p"/spaces/#{space}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Space"

      assert_patch(show_live, ~p"/spaces/#{space}/show/edit")

      assert show_live
             |> form("#space-form", space: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#space-form", space: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/spaces/#{space}")

      html = render(show_live)
      assert html =~ "Space updated successfully"
      assert html =~ "some updated description"
    end
  end
end
