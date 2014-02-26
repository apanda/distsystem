#---
# Simple service to receive messages
#---

defmodule Observable.Observable do
  use GenServer.Behaviour
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  Receive observable external messages maybe do some external things
  """
  def start_link(name) do
    :gen_server.start_link({ :local, binary_to_atom(name) }, __MODULE__, name, [])
  end

  @doc """
  Send a given kind of message to the observable agent
  """
  def send_message(name, type, msg) do
    :gen_server.call binary_to_existing_atom(name), {type, msg}
  end

  def init(name) do
    {:ok, name}
  end

  defp internal_event({type, msg}, count, name) do
    Relogger.Relogger.log_message("#{name}:#{type}:#{msg}:internal:#{count}")

  end

  def handle_call({:error, msg}, _from, name) do
    Relogger.Relogger.log_message("#{name}:normal:#{msg}:external:0")
    Enum.each 1..2, fn x ->
      internal_event({:normal, msg}, x, name)
    end
    internal_event({:error, msg}, 2, name)
    {:reply, :ok, name}
  end

  def handle_call({type, msg}, _from, name) do
    Relogger.Relogger.log_message("#{name}:#{type}:#{msg}:external:0")
    Enum.each 1..2, fn x ->
      internal_event({type, msg}, x, name)
    end
    {:reply, :ok, name}
  end

end
