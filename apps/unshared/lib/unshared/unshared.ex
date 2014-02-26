defmodule Unshared.Unshared do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  A driver for sending messages to the observer
  """
  def emulate(type, msg) do
    Observable.Observable.send_message("observer", type, msg)
  end

end
