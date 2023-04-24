defmodule ElxrBBWeb.ReplyLive.FormComponent do
  use ElxrBBWeb, :live_component

  alias ElxrBB.Forums

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage reply records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="reply-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:body]} type="text" label="Body" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Reply</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{reply: reply} = assigns, socket) do
    changeset = Forums.change_reply(reply)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"reply" => reply_params}, socket) do
    changeset =
      socket.assigns.reply
      |> Forums.change_reply(reply_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"reply" => reply_params}, socket) do
    save_reply(socket, socket.assigns.action, reply_params)
  end

  defp save_reply(socket, :edit, reply_params) do
    case Forums.update_reply(socket.assigns.reply, reply_params) do
      {:ok, reply} ->
        notify_parent({:saved, reply})

        {:noreply,
         socket
         |> put_flash(:info, "Reply updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_reply(socket, :new, reply_params) do
    case Forums.create_reply(reply_params) do
      {:ok, reply} ->
        notify_parent({:saved, reply})

        {:noreply,
         socket
         |> put_flash(:info, "Reply created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
