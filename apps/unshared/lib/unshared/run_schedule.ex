defmodule Unshared.Schedule do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  A driver for sending messages to the observer
  """
  def run_schedule(file) do
    case File.open(file, [:read]) do
      { :ok, f } ->
        schedule (f)
      { :error, reason } ->
        IO.puts("Error opening #{reason}")
        :error
    end
  end

  defp schedule (f) do
    case IO.binread(f, :line) do
      :eof -> :ok
      {:error, reason} -> :error
      l -> 
        [type, msg] = String.split(String.rstrip(l), ":")
        Unshared.Unshared.emulate(binary_to_atom(type), msg)
        schedule (f)
    end
  end

end
