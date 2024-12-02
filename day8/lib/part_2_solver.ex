defmodule Part2Solver do
  def solve(input) do
    %{locations: locs} = input

    locs
    |> Map.keys()
    |> Enum.filter(fn key -> ends_with_char?(key, "A") end)
  end

  defp ends_with_char?(str, char) do
    case str do
      <<_x::binary-size(2), letter::binary-size(1)>> when letter == char -> true
      _ -> false
    end
  end
end
