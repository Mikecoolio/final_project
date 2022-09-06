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
  end
end
