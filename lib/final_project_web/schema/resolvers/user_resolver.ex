defmodule FinalProjectWeb.Schema.Resolvers.UserResolver do
  alias FinalProject.Auth
  alias FinalProjectWeb.Utils
  alias FinalProjectWeb.Constants

  def register_user(_, %{input: input}, _) do
    case Auth.create_user(input) do
      {:ok, _} -> {:ok, true}
      {:errors, %Ecto.Changeset{} = changeset} ->
        errors = Utils.format_changeset_errors(changeset)
        {:errors, errors}

      {_, _} -> {:error, Constants.internal_server_error()}
    end
  end

  #def get_all_users(_, _, %{context: context}) do
  def get_all_users(_, _, _) do
    IO.puts("getting all users...")
    # IO.insepct(context)
    users = Auth.list_users()
    {:ok, users}
  end

end
