defmodule Unshared.Unshared do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  A driver for sending messages to the observer
  """
  def emulate(type, msg) do
    IO.puts("Emulating")
    Observable.Observable.send_message("observer", type, msg)
  end

end
