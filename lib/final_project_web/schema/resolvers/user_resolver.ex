defmodule FinalProjectWeb.Schema.Resolvers.UserResolver do
  alias FinalProject.Auth
  # alias FinalProjectWeb.FormatErrorMessages
  # alias FinalProjectWeb.ErrorMessages

  # THE FUNCTION BELOW HAS BEEN MOVED TO auth.ex

  # def register_user(_, %{input: input}, _) do
  #   case Auth.create_user(input) do
  #     {:ok, _} -> {:ok, true}
  #     {:errors, %Ecto.Changeset{} = changeset} ->
  #       errors = FormatErrorMessages.format_changeset_errors(changeset)
  #       {:errors, errors}

  #     {_, _} -> {:error, ErrorMessages.internal_server_error()}
  #   end
  # end

  def get_all_users(_, _, %{context: context}) do
    # IO.puts("getting all users (looking at context)...")
    # IO.inspect(context)
    users = Auth.list_users()
    {:ok, users}
  end

end
