defmodule Unshared.SimpleMinimize do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  Simplest minimization possible
  """
  def simple_minimize(sched) do
    simple_minimize(sched, :queue.new)
  end
  
  defp simple_minimize(curr_sched, required) do
    case curr_sched do
      [] -> :queue.to_list(required)
      [prefix | rest] ->
        case  Unshared.ErrorDetector.check_sched(Enum.concat(:queue.to_list(required), rest)) do
          true -> simple_minimize(rest, required) # Error happens even if we remove this
          false -> simple_minimize(rest, :queue.in(prefix, required)) # No error
        end
    end
  end
end
