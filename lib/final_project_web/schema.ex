defmodule FelixirWeb.Schema do
  use Absinthe.Schema

  query do
    @desc "query"
    field :test, :string do # for testing
      resolve(fn _, _ -> {:ok, "hello world"} end)
    end
  end
end
