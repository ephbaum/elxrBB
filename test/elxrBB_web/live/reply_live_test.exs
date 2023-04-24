defmodule ElxrBBWeb.ReplyLiveTest do
  use ElxrBBWeb.ConnCase

  import Phoenix.LiveViewTest
  import ElxrBB.ForumsFixtures

  @create_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  defp create_reply(_) do
    reply = reply_fixture()
    %{reply: reply}
  end

  describe "Index" do
    setup [:create_reply]

    test "lists all replies", %{conn: conn, reply: reply} do
      {:ok, _index_live, html} = live(conn, ~p"/replies")

      assert html =~ "Listing Replies"
      assert html =~ reply.body
    end

    test "saves new reply", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/replies")

      assert index_live |> element("a", "New Reply") |> render_click() =~
               "New Reply"

      assert_patch(index_live, ~p"/replies/new")

      assert index_live
             |> form("#reply-form", reply: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reply-form", reply: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/replies")

      html = render(index_live)
      assert html =~ "Reply created successfully"
      assert html =~ "some body"
    end

    test "updates reply in listing", %{conn: conn, reply: reply} do
      {:ok, index_live, _html} = live(conn, ~p"/replies")

      assert index_live |> element("#replies-#{reply.id} a", "Edit") |> render_click() =~
               "Edit Reply"

      assert_patch(index_live, ~p"/replies/#{reply}/edit")

      assert index_live
             |> form("#reply-form", reply: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#reply-form", reply: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/replies")

      html = render(index_live)
      assert html =~ "Reply updated successfully"
      assert html =~ "some updated body"
    end

    test "deletes reply in listing", %{conn: conn, reply: reply} do
      {:ok, index_live, _html} = live(conn, ~p"/replies")

      assert index_live |> element("#replies-#{reply.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#replies-#{reply.id}")
    end
  end

  describe "Show" do
    setup [:create_reply]

    test "displays reply", %{conn: conn, reply: reply} do
      {:ok, _show_live, html} = live(conn, ~p"/replies/#{reply}")

      assert html =~ "Show Reply"
      assert html =~ reply.body
    end

    test "updates reply within modal", %{conn: conn, reply: reply} do
      {:ok, show_live, _html} = live(conn, ~p"/replies/#{reply}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Reply"

      assert_patch(show_live, ~p"/replies/#{reply}/show/edit")

      assert show_live
             |> form("#reply-form", reply: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#reply-form", reply: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/replies/#{reply}")

      html = render(show_live)
      assert html =~ "Reply updated successfully"
      assert html =~ "some updated body"
    end
  end
end
