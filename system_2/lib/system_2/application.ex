defmodule System2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      System2Web.Telemetry,
      System2.Repo,
      {DNSCluster, query: Application.get_env(:system_2, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: System2.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: System2.Finch},
      # Start a worker by calling: System2.Worker.start_link(arg)
      # {System2.Worker, arg},
      # Start to serve requests, typically the last entry
      System2Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: System2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    System2Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
