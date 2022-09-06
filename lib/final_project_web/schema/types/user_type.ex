defmodule FinalProjectWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  object :user_type do
    field :id, :id
    field :email, :string
    field :password, :string
    field :username, :string
    field :inserted_at, :string
  end

  input_object :registration_input_type do
    field :username, non_null(:string)
    field :email, non_null(:string)
    field :password,non_null(:string)
  end
end
