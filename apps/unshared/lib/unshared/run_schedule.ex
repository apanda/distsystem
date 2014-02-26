defmodule Unshared.Schedule do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  A driver for running a schedule
  """

  @doc """
  Read file and return schedule list
  """
  def read_schedule(file) do
    case File.open(file, [:read]) do
      { :ok, f } ->
          stream = IO.stream(f, :line) |>
          Stream.map(&(String.rstrip(&1)))
          Enum.to_list(stream)
    end
  end

  def run_schedule(lst) do
    schedule(lst)
  end

  defp schedule(lst) do
    Enum.each(lst, fn l ->
          [type, msg] = String.split(String.rstrip(l), ":")
          Unshared.Unshared.emulate(binary_to_atom(type), msg)
        end)
  end
end
