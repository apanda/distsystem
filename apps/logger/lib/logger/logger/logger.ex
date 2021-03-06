#---
# Simple logging service
#---

defmodule Logger.Logger do
  use GenServer.Behaviour
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  Log messages sent to this thing
  """
  @name :logger 
  def start_link(fname) do
    :gen_server.start_link({ :local, @name }, __MODULE__, fname, [])
  end

  @doc """
  Log a message sent to this logger
  """
  def log_message(msg) do
    :gen_server.call @name, {:log, msg}
  end

  def init(fname) do
    IO.puts(:stderr, "Opening file")
    case File.open(fname, [:write, :utf8]) do
      {:ok, file} ->
        { :ok, file }
      {:error, reason} ->
        IO.puts "Failed to open file: #{reason}"
    end
  end

  def handle_call({:log, msg}, _from, file) do
    now = time()
    IO.puts(file, "#{now} #{msg}")
    {:reply, {:ok, msg}, file}
  end

  defp time() do
    {mega, sec, micro} = :erlang.now()
    (mega * 1000000 + sec) * 1000 + micro
  end
end
