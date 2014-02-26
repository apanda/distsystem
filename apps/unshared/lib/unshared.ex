defmodule Unshared do
  def main(args) do
    case OptionParser.parse(args) do
      {_, [name], _} ->
        Unshared.Schedule.run_schedule(name)
      _ -> raise "Usage unshared <schedule>"
    end
  end
end
