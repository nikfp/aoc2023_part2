defmodule Ranker2Test do
  use ExUnit.Case

  import RankerPart2
  

  describe("ranker_tests") do
    
    test "Five of a kind - 7" do
      assert extract_primary_rank("QQQQQ") == 7
    end
    test "Five jokers - 7" do
      assert extract_primary_rank("JJJJJ") == 7
    end

    test "four of a kind with joker - 7" do
      assert extract_primary_rank("QQQQJ") == 7
    end

    test "four jokers with outlier - 7" do
      assert extract_primary_rank("QJJJJ") == 7
    end

    test "Four of a kind no jokers - 6" do
      assert extract_primary_rank("QQQQT") == 6
    end

    test "full house 3 jokers - 7" do
      assert extract_primary_rank("JJJQQ") == 7
    end

    test "full house 2 jokers - 7" do
      assert extract_primary_rank("JJQQQ") == 7
    end

    test "Full house no jokers - 5" do
      assert extract_primary_rank("KKQQQ") == 5
    end

    test "Three of a kind joker outlier - 6" do
      assert extract_primary_rank("QQQ2J") == 6
    end

    test "Three of a kind no jacks" do
      assert extract_primary_rank("QQQ28") == 4
    end


    test "Two pair one is jacks - 6" do
      assert extract_primary_rank("JQQ3J") == 6
    end

  end

  def build_hand(cards) do
    %{
      cards: cards, 
      bid: 200
    }
  end

  def extract_primary_rank(cards) do
    cards
      |> build_hand()
      |> add_tuple_give_rank()
    |> Map.get(:primary_rank)
  end

end
