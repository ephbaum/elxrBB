defmodule ElxrBBWeb.ReplyLive.Index do
  use ElxrBBWeb, :live_view

  alias ElxrBB.Forums
  alias ElxrBB.Forums.Reply

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :replies, Forums.list_replies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reply")
    |> assign(:reply, Forums.get_reply!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Reply")
    |> assign(:reply, %Reply{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Replies")
    |> assign(:reply, nil)
  end

  @impl true
  def handle_info({ElxrBBWeb.ReplyLive.FormComponent, {:saved, reply}}, socket) do
    {:noreply, stream_insert(socket, :replies, reply)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    reply = Forums.get_reply!(id)
    {:ok, _} = Forums.delete_reply(reply)

    {:noreply, stream_delete(socket, :replies, reply)}
  end
end
