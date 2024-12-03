defmodule Part2Solver do
  def solve(input) do
    %{locations: locs, instructions: inst} = input

    locs
    |> Map.keys()
    |> Enum.filter(fn key -> ends_with_char?(key, "A") end)
    |> Enum.map(fn el ->
      process(el, inst, 0, input)
    end)
    |> lcm_list()
  end

  defp gcd(a, b) when b == 0, do: abs(a)
  defp gcd(a, b), do: gcd(b, rem(a, b))

  defp lcm(0, 0), do: 0
  defp lcm(a, b), do: div(abs(a * b), gcd(a, b))

  defp lcm_list([]), do: 0
  defp lcm_list([x]), do: x

  defp lcm_list(numbers) do
    Enum.reduce(numbers, &lcm/2)
  end

  defp ends_with_char?(str, char) do
    case str do
      <<_x::binary-size(2), letter::binary-size(1)>> when letter == char -> true
      _ -> false
    end
  end

  defp process(pos, [], count, %{instructions: inst, locations: location_list} = data) do
    [next_move | rest_moves] = inst

    if ends_with_char?(pos, "Z") do
      count
    else
      case next_move do
        "L" ->
          {new, _} = Map.get(location_list, pos)
          new

        "R" ->
          {_, new} = Map.get(location_list, pos)
          new
      end
      |> process(rest_moves, count + 1, data)
    end
  end

  defp process(
         pos,
         [next_move | rest_moves],
         count,
         %{locations: location_list} = data
       ) do
    if ends_with_char?(pos, "Z") do
      count
    else
      case next_move do
        "L" ->
          {new, _} = Map.get(location_list, pos)
          new

        "R" ->
          {_, new} = Map.get(location_list, pos)
          new
      end
      |> process(rest_moves, count + 1, data)
    end
  end
end
