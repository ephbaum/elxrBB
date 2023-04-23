defmodule ElxrBB.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]

  import Ecto.Changeset

  alias Bcrypt

  schema "users" do
    pow_user_fields()

    field :username, :string
    field :bio, :string

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:email, :username, :password])
    |> validate_required([:email, :username, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_length(:username, min: 3)
    |> validate_length(:password, min: 8)
    |> pow_changeset(attrs)
    |> maybe_validate_current_password(attrs)
    |> pow_extension_changeset(attrs)
  end
  
  defp maybe_validate_current_password(changeset, %{"current_password" => current_password} = _attrs) do
    changeset
    |> validate_current_password(current_password)
  end

  defp maybe_validate_current_password(changeset, _attrs) do
    changeset
  end

  def validate_current_password(changeset, %{password_hash: password_hash} = _user) do
    password = Ecto.Changeset.get_change(changeset, :current_password)

    case Bcrypt.verify_pass(password, password_hash) do
      true ->
        changeset
        |> Ecto.Changeset.put_change(:password_hash, password_hash)
      false ->
        changeset
        |> Ecto.Changeset.add_error(:current_password, "is invalid")
    end
  end

  def invite_changeset(user_or_changeset, invited_by, attrs) do
    user_or_changeset
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> put_change(:invitation_token, Pow.UUID.generate())
    |> unique_constraint(:invitation_token)
    |> put_assoc(:invited_by, invited_by)
    |> assoc_constraint(:invited_by)
  end
end
