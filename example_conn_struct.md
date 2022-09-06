%Plug.Conn{
  adapter: {Plug.Cowboy.Conn, :...},
  assigns: %{},
  body_params: %{},
  cookies: %{
    "_final_project_key" => "SFMyNTY.g3QAAAAA.NMZ93ggqD28WIhFbsQL7hpzZw_VyJxLk0dnrooaa5Do"
  },
  halted: false,
  host: "localhost",
  method: "GET",
  owner: #PID<0.760.0>,
  params: %{},
  path_info: ["api", "auth", "getme"],
  path_params: %{},
  port: 4000,
  private: %{
    FinalProjectWeb.Router => {[], %{}},
    :before_send => [#Function<0.323658/1 in Plug.Session.before_send/2>,
     #Function<0.20582249/1 in Plug.Telemetry.call/2>,
     #Function<1.84401372/1 in Phoenix.LiveReloader.before_send_inject_reloader/3>],
    :phoenix_endpoint => FinalProjectWeb.Endpoint,
    :phoenix_format => "json",
    :phoenix_request_logger => {"request_logger", "request_logger"},
    :phoenix_router => FinalProjectWeb.Router,
    :plug_session => %{},
    :plug_session_fetch => :done
  },
  query_params: %{},
  query_string: "",
  remote_ip: {127, 0, 0, 1},
  req_cookies: %{
    "_final_project_key" => "SFMyNTY.g3QAAAAA.NMZ93ggqD28WIhFbsQL7hpzZw_VyJxLk0dnrooaa5Do"
  },
  req_headers: [
    {"accept", "*/*"},
    {"content-length", "15"},
    {"content-type", "application/json"},
    {"cookie",
     "_final_project_key=SFMyNTY.g3QAAAAA.NMZ93ggqD28WIhFbsQL7hpzZw_VyJxLk0dnrooaa5Do"},
    {"host", "localhost:4000"},
    {"user-agent", "insomnia/2022.5.1"}
  ],
  request_path: "/api/auth/getme",
  resp_body: nil,
  resp_cookies: %{},
  resp_headers: [
    {"cache-control", "max-age=0, private, must-revalidate"},
    {"x-request-id", "FxI1R1EtTw_Dp5cAAAOF"}
  ],
  scheme: :http,
  script_name: [],
  secret_key_base: :...,
  state: :unset,
  status: nil
}
