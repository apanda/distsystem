defmodule Observable.Supervisor do
  use Supervisor.Behaviour

  def start_link (observer_name) do
    :supervisor.start_link(__MODULE__, observer_name)
  end

  def init(observer_name) when is_binary(observer_name) do
    children = [
      # Define workers and child supervisors to be supervised
      # worker(Observable.Worker, [])
      worker(Observable.Observable, [observer_name]) 
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
