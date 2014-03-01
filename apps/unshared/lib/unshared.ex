defmodule Unshared do
  def main(args) do
    case OptionParser.parse(args) do
      {_, [name], _} ->
      sched  = Unshared.Schedule.read_schedule(name)
      min_sched = Unshared.SimpleMinimize.simple_minimize(sched)
      IO.puts "==== MINIMIZED SCHEDULE ===="
      Enum.each min_sched, fn s ->
        IO.puts s
      end
      delta_sched = Unshared.DeltaDebugMinimize.delta_minimize(sched)
      IO.puts "==== DELTA MINIMIZED SCHEDULE ===="
      Enum.each delta_sched, fn s ->
        IO.puts s
      end
      _ -> raise "Usage unshared <schedule>"
    end
  end
end
