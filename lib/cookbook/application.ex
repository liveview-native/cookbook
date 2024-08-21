defmodule Cookbook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CookbookWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:cookbook, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Cookbook.PubSub},
      # Start a worker by calling: Cookbook.Worker.start_link(arg)
      # {Cookbook.Worker, arg},
      # Start to serve requests, typically the last entry
      CookbookWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cookbook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CookbookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
