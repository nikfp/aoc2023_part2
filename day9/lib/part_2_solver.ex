defmodule Part2Solver do
  def solve(input) do
    input
    |> Enum.map(&get_next_entry/1)
    |> Enum.sum()
  end

  defp get_next_entry(inputs) do
    diffs =
      inputs
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [l, r] -> r - l end)

    if Enum.uniq(diffs) |> Enum.count() == 1 do
      List.first(inputs) - List.first(diffs)
    else
      List.first(inputs) - get_next_entry(diffs)
    end
  end
end
