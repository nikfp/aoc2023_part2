Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Parser
alias Part1Solver

input = Parser.parse("./inputs/test1.txt")

Map.update(input, :locations, %{}, fn locs -> Parser.locations_list_to_map(locs) end)
|> Map.put(:starting_loc, "AAA")
|> Part1Solver.solve()
|> IO.inspect()
