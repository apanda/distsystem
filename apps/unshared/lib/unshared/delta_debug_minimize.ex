defmodule Unshared.DeltaDebugMinimize do
  @vsn 0
  @author "Aurojit Panda"
  @moduledoc """
  Delta debugging minimization
  """
  def delta_minimize(sched) do
    delta_minimize_subset(sched, 2)
  end

  defp delta_minimize_subset(sched, subsets) do
    #IO.puts("Calling delta_minimize_subset #{inspect sched} with subsets #{subsets}")
    # Divide schedule into subsets
    size = div(length(sched), subsets)
    if size == 0 do
      sched
    else
      scheds = Enum.chunk(sched, size, size, [])
      #IO.puts "Subsets: #{inspect scheds}"
      case check_scheds(scheds) do
        {:cross, nsched} -> # Found a smaller scheduler
          delta_minimize_subset(nsched, 2) # Reduce to subset
         _ -> # No subset found
          delta_minimize_complement(sched, subsets)
      end
    end
  end

  defp delta_minimize_complement(sched, subsets) do
    #IO.puts("Calling delta_minimize_complement #{inspect sched} with subsets #{subsets}")
    size = div(length(sched), subsets)
    len = length sched
    indices = Enum.map(Enum.chunk(0 .. (len - 1), size, size, []), 
                   fn (x) -> 
                      Enum.reject(0 .. (len - 1), fn(y) -> y in x end)
                   end)
    scheds = Enum.map(indices, 
                fn(idx) -> 
                   Enum.map(idx, fn(i) -> Enum.at(sched, i) end)
                end)
    #IO.puts "Complements: #{inspect scheds} (Indicies #{inspect Enum.chunk(0 .. (len - 1), size, size, [])})"
    case check_scheds(scheds) do
      {:cross, nsched} -> # Reduce to complement
        delta_minimize_subset(nsched, max(subsets - 1, 2))
      _ -> # Neither complement nor subset lead to error
        if subsets < len do
          delta_minimize_subset(sched, min(2 * subsets, len))
        else
          sched
        end
    end
  end

  defp check_scheds(scheds) do
    case scheds do
      [] -> {:check, nil}
      [sched | rest] -> 
        case  Unshared.ErrorDetector.check_sched(sched) do
          true -> {:cross, sched} # Short circuit
          false -> check_scheds (rest) # Check the rest of them
        end
    end
  end
  
end
