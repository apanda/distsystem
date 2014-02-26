defmodule Unshared.ErrorDetector do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  Detect if an error occurred
  """

  def error_occured do
    {:ok, lst} = Relogger.Relogger.get_all
    Enum.any?(lst, &(is_error(&1)))
  end

  defp is_error(str) do
    Enum.at(String.split(str, ":"), 1) === "error"
  end
end
