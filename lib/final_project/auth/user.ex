defmodule FinalProject.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> validate_length(:username, min: 3, max: 35)
    |> validate_length(:password, min: 3, max: 40)
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> hash_password()
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
