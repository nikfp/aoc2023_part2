defmodule Parser do
  def parse(file_name) do
    File.read!(file_name)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [cards, bid] = String.split(line, " ")

      %{
        cards: cards,
        bid: String.to_integer(bid)
      }
    end)
  end
end
