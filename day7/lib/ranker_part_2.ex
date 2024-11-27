defmodule RankerPart2 do
  def rank_hands(hands_list) do
    hands_list
    # |> Enum.map(&add_card_tuple_to_hand/1)
    # Primary rank is order of poker hands per exercise
    |> Enum.map(&add_tuple_give_rank/1)
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

  def add_tuple_give_rank(hand) do
    hand
    |> add_card_tuple_to_hand()
    |> give_primary_rank()
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
        # all the same, 5 of a kind
        [_] -> 7
        # four of a kind, one kind is jacks
        # change to five of a kind -> 7
        [{1, 4}, {_, 1}] -> 7
        [{_, 4}, {1, 1}] -> 7
        # four of a kind -> 6
        [{_, 4}, _] -> 6
        # Full house, one kind is jacks -> 7
        [{1, 3}, {_, 2}] -> 7
        [{_, 3}, {1, 2}] -> 7
        # Full house -> 5
        [{_, 3}, _] -> 5
        # Three of a kind, 3 jacks
        [{1, 3}, _, _] -> 6
        # Three of a kind, one jack outlier
        [{_, 3}, {1, _}, _] -> 6
        [{_, 3}, _, {1, _}] -> 6
        # Three of a kind
        [{_, 3}, _, _] -> 4
        # Two pair, one pair is jacks
        [{1, 2}, {_, 2}, _] -> 6
        [{_, 2}, {1, 2}, _] -> 6
        # Two pair, outlier is jacks
        [{_, 2}, {_, 2}, {1, _}] -> 4
        # Two pair
        [{_, 2}, {_, 2}, _] -> 3
        # Single pair, pair is jacks
        [{1, 2}, {_, _}, _, _] -> 4
        # Single pair, jack outlier
        [{_, 2}, {1, _}, _, _] -> 4
        [{_, 2}, _, {1, _}, _] -> 4
        [{_, 2}, _, _, {1, _}] -> 4
        # Single pair
        [{_, 2}, _, _, _] -> 2
        # High card, any jack
        [{1, _}, _, _, _, _] -> 2
        [_, {1, _}, _, _, _] -> 2
        [_, _, {1, _}, _, _] -> 2
        [_, _, _, {1, _}, _] -> 2
        [_, _, _, _, {1, _}] -> 2
        # High card
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
      "J" -> 1
      "Q" -> 11
      "K" -> 12
      "A" -> 13
    end
  end

  defp can_parse_int?(string) do
    case Integer.parse(string) do
      {_, ""} -> true
      _ -> false
    end
  end
end
