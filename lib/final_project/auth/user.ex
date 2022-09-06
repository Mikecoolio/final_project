defmodule FinalProject.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias FinalProject.Auth.User

  schema "users" do
    field :email, :string
    field :is_admin, :boolean, default: false
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :is_admin])
    |> validate_required([:email, :username, :password, :is_admin])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> update_change(:username, fn username -> String.downcase(username) end)
    |> validate_length(:username, min: 3, max: 35)
    |> validate_length(:password, min: 3, max: 40)
    |> hash_password()
  end

  def login_changeset(attrs) do
    %User{}
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> update_change(:username, fn username -> String.downcase(username) end)
  end

  defp hash_password(%Ecto.Changeset{} = changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        new_changeset = put_change(changeset, :password, Argon2.hash_pwd_salt(password))
        new_changeset

      _ -> changeset
    end
  end
end
