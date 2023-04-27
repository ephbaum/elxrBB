defmodule ElxrBBWeb.PowHelpers do
    alias Pow.Phoenix.ViewHelpers
  
    def current_user(conn) do
      ViewHelpers.current_user(conn)
    end
  
    def current_user_from_assigns(assigns) do
      case assigns do
        %{conn: conn} -> current_user(conn)
        %{socket: %{assigns: inner_assigns}} -> current_user_from_assigns(inner_assigns)
        _ -> nil
      end
    end
  end
  