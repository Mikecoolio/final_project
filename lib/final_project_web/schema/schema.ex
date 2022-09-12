defmodule FinalProjectWeb.Schema do
  use Absinthe.Schema
  alias FinalProjectWeb.Schema.Resolvers

  import_types(FinalProjectWeb.Schema.Types)


  query do
    @desc "query"
    field :test, :string do # for testing in graphql
      resolve(fn _, _ -> {:ok, "hello world"} end)
    end

    @desc "Get all Users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.get_all_users/3)
    end

  end
end
