defmodule Nya.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Nya.Repo,
      # Start the Telemetry supervisor
      NyaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Nya.PubSub},
      # Start the Endpoint (http/https)
      NyaWeb.Endpoint
      # Start a worker by calling: Nya.Worker.start_link(arg)
      # {Nya.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nya.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NyaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
