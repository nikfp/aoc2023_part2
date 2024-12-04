IO.inspect("\nStarting run script\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Parser
alias Part1Solver

test_input_1 = Parser.parse("./inputs/test.txt")

test_input_1
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1", charlists: :as_integers)
