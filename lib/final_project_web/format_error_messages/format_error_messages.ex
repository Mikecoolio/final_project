defmodule FinalProjectWeb.FormatErrorMessages do
  import Ecto.Changeset

  def format_changeset_errors(%Ecto.Changeset{} = changeset) do
    # https://hexdocs.pm/ecto/Ecto.Changeset.html#traverse_errors/2
    errors =
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)

    formatted_errors =
      Enum.map(errors, fn {key, value}
      ->
        formatter_error = "#{key} #{value}"
        # formatter_error
        IO.inspect(key)
        IO.inspect(value)
    end)

    formatted_errors
  end
end
