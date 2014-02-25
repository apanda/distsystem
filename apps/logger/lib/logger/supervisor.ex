defmodule Logger.Supervisor do
  use Supervisor.Behaviour

  def start_link (fname) do
    :supervisor.start_link(__MODULE__, fname)
  end

  def init(fname) do
    children = [
      # Define workers and child supervisors to be supervised
      # worker(Events.Worker, [])
      worker(Logger.Logger, [fname])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
