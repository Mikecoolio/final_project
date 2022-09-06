defmodule FinalProjectWeb.Schema.Resolvers.UserResolver do
  alias FinalProject.Auth
  alias FinalProjectWeb.Utils
  def register_user(_, %{input: input}, _) do
    case Auth.create_user(input) do
      {:ok, _} -> {:ok, true}
      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Utils.format_changeset_errors(changeset)
        {:errors, errors}

      {_, _} -> {:error, "Internal Server Error"} # fallthough case
    end
  end
end
