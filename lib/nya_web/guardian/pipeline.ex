defmodule Nya.Guardian.Pipeline do
  use( Guardian.Plug.Pipeline,
    otp_app: :nya,
    error_handler: Nya.Guardian.ErrorHandler,
    module: Nya.Guardian )

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.LoadResource,  allow_blank: true)
end
