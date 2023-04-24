defmodule ElxrBBWeb.TopicLive.Index do
  use ElxrBBWeb, :live_view

  alias ElxrBB.Forums
  alias ElxrBB.Forums.Topic

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :topics, Forums.list_topics())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Topic")
    |> assign(:topic, Forums.get_topic!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Topic")
    |> assign(:topic, %Topic{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Topics")
    |> assign(:topic, nil)
  end

  @impl true
  def handle_info({ElxrBBWeb.TopicLive.FormComponent, {:saved, topic}}, socket) do
    {:noreply, stream_insert(socket, :topics, topic)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    topic = Forums.get_topic!(id)
    {:ok, _} = Forums.delete_topic(topic)

    {:noreply, stream_delete(socket, :topics, topic)}
  end
end
