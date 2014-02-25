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
    :gen_server.cast binary_to_existing_atom(name), {type, msg}
  end

  def init(name) do
    {:ok, name}
  end

  def handle_cast({type, msg}, name) do
    Logger.Logger.log_message("#{name}:#{type}: #{msg}")
    {:noreply, name}
  end
end
