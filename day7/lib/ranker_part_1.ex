defmodule RankerPart1 do
  def rank_hands(hands_list) do
    hands_list
    |> Enum.map(&add_card_tuple_to_hand/1)
    # Primary rank is order of poker hands per exercise
    |> Enum.map(&give_primary_rank/1)
    # Group by primary rank
    |> Enum.group_by(& &1.primary_rank)
    # Order based on primary rank
    |> Enum.sort_by(fn {k, _} -> k end)
    # Order lists of hands in each rank by secondary rank
    |> Enum.map(fn {rank, hands} ->
      # This sort takes advantage of tuple comparison in order
      sorted_hands =
        Enum.sort_by(hands, & &1.card_tuple)

      {rank, sorted_hands}
    end)
    # Map to a list of lists and then flatten
    |> Enum.flat_map(fn {_, hands} -> hands end)
    # Add in an index for a rank
    |> Enum.with_index(1)

  end

  defp give_primary_rank(hand) do
    %{card_tuple: card_tuple} = hand

    primary_rank =
      card_tuple
      |> Tuple.to_list()
      |> Enum.reduce(%{}, fn card, card_map ->
        Map.update(card_map, card, 1, fn count -> count + 1 end)
      end)
      |> Map.to_list()
      |> Enum.sort_by(fn {_, count} -> count end, :desc)
      |> case do
        [_] -> 7
        [{_, 4}, _] -> 6
        [{_, 3}, _] -> 5
        [{_, 3}, _, _] -> 4
        [_, _, _] -> 3
        [{_, 2}, _, _, _] -> 2
        _ -> 1
      end

    Map.put(hand, :primary_rank, primary_rank)
  end

  defp add_card_tuple_to_hand(%{cards: cards} = hand) do
    hand
    |> Map.put(:card_tuple, build_card_tuple(cards))
  end

  defp build_card_tuple(cards) do
    [a, b, c, d, e] =
      cards
      |> String.split("")
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&rank_card/1)

    {a, b, c, d, e}
  end

  defp rank_card(card) do
    case can_parse_int?(card) do
      true -> String.to_integer(card)
      false -> rank_face_card(card)
    end
  end

  defp rank_face_card(card) do
    case card do
      "T" -> 10
      "J" -> 11
      "Q" -> 12
      "K" -> 13
      "A" -> 14
    end
  end

  defp can_parse_int?(string) do
    case Integer.parse(string) do
      {_, ""} -> true
      _ -> false
    end
  end
end
