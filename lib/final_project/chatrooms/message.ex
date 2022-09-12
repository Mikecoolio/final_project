defmodule FinalProject.Chatrooms.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :user_id])
    |> validate_required([:body, :user_id])
    |> validate_length(:body, min: 2, max: 500)
  end
end
