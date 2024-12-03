Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)
Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Parser
alias Part1Solver
alias Part2Solver

input1 = Parser.parse("./inputs/test1.txt")
input2 = Parser.parse("./inputs/test2.txt")

prod_input = Parser.parse("./inputs/prod.txt")

solver = fn input -> 
Map.update(input, :locations, %{}, fn locs -> Parser.locations_list_to_map(locs) end)
|> Map.put(:starting_loc, "AAA")
|> Part1Solver.solve()
end

solver.(input1)
|> IO.inspect(label: "Part 1 input 1")
solver.(input2)
|> IO.inspect(label: "Part 1 input 2")

solver.(prod_input)
|> IO.inspect(label: "Part 1 prod")

part_2_test_input = Parser.parse("./inputs/test_part_2.txt")

part_2_test_input
|> Map.update(:locations, %{}, fn locs -> Parser.locations_list_to_map(locs) end)
|> Part2Solver.solve()
|>IO.inspect(label: "Part 2 input 1")

IO.puts("\nStarting part 2 prod run")

prod_input
|> Map.update(:locations, %{}, fn locs -> Parser.locations_list_to_map(locs) end)
|> Part2Solver.solve()
|>IO.inspect(label: "Part 2 prod")


