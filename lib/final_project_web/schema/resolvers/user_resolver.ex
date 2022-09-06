defmodule FinalProjectWeb.Schema.Resolvers.UserResolver do
  def register_user(_, %{input: input}, _) do
    IO.inspect(input)
    {:ok, true}
  end
end
