defmodule FinalProjectWeb.Schema do
  use Absinthe.Schema
  alias FinalProjectWeb.Schema.Resolvers

  import_types(FinalProjectWeb.Schema.Types)


  query do
    @desc "query"
    field :test, :string do # for testing in graphql
      resolve(fn _, _ -> {:ok, "hello world"} end)
    end
  end

  mutation do
    field :register_user, :boolean do
      arg(:input, non_null(:registration_input_type))
      resolve(&Resolvers.UserResolver.register_user/3)
    end
  end
end
