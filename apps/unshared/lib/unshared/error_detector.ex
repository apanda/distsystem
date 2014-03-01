defmodule Unshared.ErrorDetector do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  Detect if an error occurred
  """

  def error_occured do
    {:ok, lst} = Relogger.Relogger.get_all
    Enum.any?(lst, &(is_error(&1))) and Enum.any?(lst, &(is_error1(&1)))
  end

  defp is_error(str) do
    Enum.at(String.split(str, ":"), 1) === "error"
  end

  defp is_error1(str) do
    Enum.at(String.split(str, ":"), 1) === "error1"
  end
end
