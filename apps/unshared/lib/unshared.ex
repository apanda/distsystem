defmodule Unshared do
  def main(args) do
    case OptionParser.parse(args) do
      {_, [name], _} ->
        case Unshared.Schedule.run_schedule(name) do
          :ok -> IO.puts("Done")
          _ -> IO.puts("Something went wrong")
        end
      _ -> raise "Usage unshared <schedule>"
    end
  end
end
