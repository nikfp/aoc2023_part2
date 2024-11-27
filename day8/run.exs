Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

input = Parser.parse("./inputs/test1.txt")

Map.update(input, :locations, %{}, fn locs -> Parser.locations_list_to_map(locs) end)
|> Map.put(:starting_loc, "AAA")
|> IO.inspect()
