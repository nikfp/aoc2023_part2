defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn el ->
      String.split(el, " ")
      |> Enum.map(fn str -> String.to_integer(str) end)
    end)
  end
end
