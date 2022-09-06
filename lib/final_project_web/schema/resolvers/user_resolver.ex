defmodule FinalProjectWeb.Schema.Resolvers.UserResolver do
  alias FinalProject.Auth

  def register_user(_, %{input: input}, _) do
    resp = Auth.create_user(input)
    IO.puts("input: ")
    IO.inspect(input)
    {:ok, true}
  end


end
