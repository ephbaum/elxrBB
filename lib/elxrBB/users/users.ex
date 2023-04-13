defmodule ElxrBB.Users do
  alias ElxrBB.Repo
  alias ElxrBB.Users.User

  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  def get_user_by_confirmation_token(token), do: Repo.get_by(User, confirmation_token: token)

  def get_user_by_id(id), do: Repo.get(User, id)

  def get_user_by_password_reset_token(token), do: Repo.get_by(User, password_reset_token: token)

  def list_users, do: Repo.all(User)

  def register_user(attrs), do: User.changeset(%User{}, attrs) |> Repo.insert()

  def update_user(%User{} = user, attrs), do: User.changeset(user, attrs) |> Repo.update()

  def delete_user(user), do: Repo.delete(user)
end
