defmodule Parser do
  def parse(file) do
    File.read!(file)
    |> String.trim()
  end
end
