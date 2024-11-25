defmodule Parser do
  def match_inputs([cards, bet]) do
    %{cards: cards, bet: bet}
  end
end


File.read!("./inputs/test.txt")
|> String.trim()
|> String.split("\n")
|> Enum.map(fn input -> 
  String.split(input, " ")
  |> Parser.match_inputs() 
end)
|> IO.inspect()

