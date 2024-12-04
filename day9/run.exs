IO.inspect("\nStarting run script\n")

Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

test_input_1 = Parser.parse("./inputs/test.txt")

test_input_1
|> IO.inspect(label: "test part 1")
