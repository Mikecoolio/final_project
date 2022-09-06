defmodule FinalProjectWeb.Constants do
  @internal_server_error "Internal Server Error"
  @not_authorized "Not Authorized"
  @invalid_credentials "Invalid Credentials"
  @not_authenticated "Not Authenticated"

  def internal_server_error, do: @internal_server_error
  def not_authorized, do: @not_authorized
  def invalid_credentials, do: @invalid_credentials
  def not_authenticated, do: @not_authenticated
end
