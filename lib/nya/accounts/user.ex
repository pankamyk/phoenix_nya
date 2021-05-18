defmodule Nya.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema("users") do
    field(:email,    :string)
    field(:username, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:is_admin, :boolean, default: false)

    timestamps([type: :utc_datetime_usec])
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 2, max: 64)
    |> validate_length(:password, min: 10, max: 100)
    |> validate_confirmation(:password, required: true)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
