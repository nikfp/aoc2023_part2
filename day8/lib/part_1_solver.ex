defmodule Part1Solver do
  def solve(
        %{
          instructions: inst,
          starting_loc: start
        } = puzzle_input
      ) do
    process(puzzle_input, inst, start, 0)
  end

  defp process(_data, _moves, "ZZZ", move_count) do
    move_count
  end

  defp process(
         %{locations: locs} = data,
         [next_move | rest_moves],
         current_loc,
         move_count
       ) do
    case next_move do
      "L" ->
        {next_loc, _} = Map.get(locs, current_loc)

        process(data, rest_moves, next_loc, move_count + 1)

      "R" ->
        {_, next_loc} = Map.get(locs, current_loc)

        process(data, rest_moves, next_loc, move_count + 1)
    end
  end

  defp process(
         %{locations: locs, instructions: inst} = data,
         [],
         current_loc,
         move_count
       ) do
    [next_move | rest_moves] = inst

    case next_move do
      "L" ->
        {next_loc, _} = Map.get(locs, current_loc)

        process(data, rest_moves, next_loc, move_count + 1)

      "R" ->
        {_, next_loc} = Map.get(locs, current_loc)

        process(data, rest_moves, next_loc, move_count + 1)
    end
  end
end
