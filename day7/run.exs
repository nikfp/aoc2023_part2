Code.require_file("lib/parser.ex", __DIR__)
Code.require_file("lib/ranker_part_1.ex", __DIR__)
Code.require_file("lib/ranker_part_2.ex", __DIR__)

# Add some leading space
IO.puts("\n\n")

alias Parser
alias RankerPart1
alias RankerPart2

# Parser.parse("./day7/inputs/test.txt")
# |> RankerPart1.rank_hands()
# # Map ranked hands to bid * index
# |> Enum.map(fn {%{bid: bid}, index} -> bid * index end)
# |> Enum.sum()
# |> IO.inspect(label: "Part 1 test")
#
# Parser.parse("./day7/inputs/prod.txt")
# |> RankerPart1.rank_hands()
# # Map ranked hands to bid * index
# |> Enum.map(fn {%{bid: bid}, index} -> bid * index end)
# |> Enum.sum()
# |> IO.inspect(label: "Part 1 prod")

Parser.parse("./day7/inputs/test.txt")
|> RankerPart2.rank_hands()
# Map ranked hands to bid * index
|> Enum.map(fn {%{bid: bid}, index} -> bid * index end)
|> Enum.sum()
|> IO.inspect(label: "Part 2 test")

Parser.parse("./day7/inputs/prod.txt")
|> RankerPart2.rank_hands()
# Map ranked hands to bid * index
|> Enum.map(fn {%{bid: bid}, index} -> bid * index end)
|> Enum.sum()
|> IO.inspect(label: "Part 2 prod")
