defmodule ElxrBB.UsersTest do
  use ElxrBB.DataCase, async: true

  alias ElxrBB.Users
  alias ElxrBB.Users.User

  defp user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{email: "test@example.com", password: "password", password_confirmation: "password"})
      |> Users.register_user()

    user
  end

  defp valid_user_password do
    "password"
  end

  describe "Users" do
    # Set up a valid user attributes map
    @valid_attrs %{email: "test@example.com", password: "password", password_confirmation: "password"}

    test "list_users/0 lists all users" do
      _user = Users.register_user(@valid_attrs)
      assert [%User{}] = Users.list_users()
    end

    test "register_user/1 registers a user with valid attributes" do
      {:ok, user} = Users.register_user(@valid_attrs)
      assert user.email == @valid_attrs.email
    end

    test "get_user_by_email/1 gets a user by email" do
      {:ok, user} = Users.register_user(@valid_attrs)
      assert Users.get_user_by_email(user.email) == user
    end

    test "update_user/2 updates a user's email" do
      user = user_fixture()
      new_email = "updated@example.com"
      attrs = %{email: new_email, current_password: valid_user_password()}
      
      # Call update_user/2 and store the result in a variable
      update_result = Users.update_user(user, attrs)

      # Match the result with the {:ok, updated_user} tuple
      {:ok, updated_user} = update_result

      assert updated_user.unconfirmed_email == new_email
    end

    test "delete_user/1 deletes a user" do
      {:ok, user} = Users.register_user(@valid_attrs)
      assert {:ok, _} = Users.delete_user(user)
      assert Users.get_user_by_id(user.id) == nil
    end
  end
end
