defmodule ElxrBBWeb.SessionController do
  use ElxrBBWeb, :controller
  use Pow.Phoenix.Controller, action: Pow.Phoenix.SessionController

  def create(conn, %{"user" => user_params}) do
    IO.inspect(user_params)  # Log the user_params for debugging

    case Pow.Plug.create(conn, user_params) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, conn} ->
        conn
        |> put_flash(:error, "Invalid credentials.")
        |> render("new.html", changeset: Pow.Plug.current_changeset(conn))
    end
  end
end
