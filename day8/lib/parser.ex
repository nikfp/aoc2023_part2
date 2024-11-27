defmodule Parser do
  def parse(file) do
    [instructions, locations] =
      File.read!(file)
      |> String.trim()
      |> String.split("\n\n")

    %{
      instructions: instructions |> parse_instructions(),
      locations: locations |> parse_locations()
    }
  end

  defp parse_locations(location_list) do
    location_list
    |> String.split("\n")
    |> Enum.map(&parse_location/1)
  end

  defp parse_location(location) do
    <<loc::binary-size(3), " = (", left::binary-size(3), ", ", right::binary-size(3), ")">> =
      location

      {loc, left, right}
  end

  defp parse_instructions(instructions) do
    instructions
    |> String.trim()
    |> String.split("")
    |> Enum.filter(&(&1 != ""))
  end

  def locations_list_to_map(locations) do
    locations
    |> Enum.reduce(%{}, fn {loc, left, right}, acc -> 
      Map.put(acc, loc, {left, right})
    end)
  end
end
