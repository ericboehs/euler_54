require_relative '../../lib/poker'
require 'minitest/autorun'

module Poker
  class HandTest < MiniTest::Test
    def six_of_hearts
      Poker::Card.new '6', 'h'
    end

    def eight_of_hearts
      Poker::Card.new '8', 'h'
    end

    def nine_of_hearts
      Poker::Card.new '9', 'h'
    end

    def ten_of_hearts
      Poker::Card.new 't', 'h'
    end

    def jack_of_hearts
      Poker::Card.new 'j', 'h'
    end

    def queen_of_spades
      Poker::Card.new 'q', 's'
    end

    def queen_of_hearts
      Poker::Card.new 'q', 'h'
    end

    def king_of_hearts
      Poker::Card.new 'k', 'h'
    end

    def ace_of_hearts
      Poker::Card.new 'a', 'h'
    end

    def ace_of_spades
      Poker::Card.new 'a', 's'
    end

    def test_highest_card
      cards = [ace_of_spades, nine_of_hearts, ten_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal 'A', hand.highest_card.value
    end

    def test_score_pair
      cards = [ace_of_spades, ace_of_spades, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :one_pair, hand.score
    end

    def test_score_two_pair
      cards = [ace_of_spades, ace_of_spades, nine_of_hearts, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :two_pair, hand.score
    end

    def test_score_three_of_a_kind
      cards = [ace_of_spades, ace_of_spades, ace_of_spades, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :three_of_a_kind, hand.score
    end

    def test_score_straight
      cards = [queen_of_spades, ten_of_hearts, jack_of_hearts, eight_of_hearts, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :straight, hand.score
    end

    def test_score_flush
      cards = [six_of_hearts, ten_of_hearts, jack_of_hearts, eight_of_hearts, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :flush, hand.score
    end

    def test_score_full_house
      cards = [ace_of_spades, ace_of_spades, ace_of_spades, nine_of_hearts, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :full_house, hand.score
    end

    def test_score_four_of_a_kind
      cards = [ace_of_spades, ace_of_spades, ace_of_spades, ace_of_spades, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :four_of_a_kind, hand.score
    end

    def test_score_straight_flush
      cards = [queen_of_hearts, ten_of_hearts, jack_of_hearts, eight_of_hearts, nine_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :straight_flush, hand.score
    end

    def test_score_royal_flush
      cards = [queen_of_hearts, ten_of_hearts, jack_of_hearts, king_of_hearts, ace_of_hearts]
      hand = Poker::Hand.new cards
      assert_equal :royal_flush, hand.score
    end

    def test_score_comparison
      royal_flush = Poker::Hand.new [queen_of_hearts, ten_of_hearts, jack_of_hearts, king_of_hearts, ace_of_hearts]
      straight_flush = Poker::Hand.new [queen_of_hearts, ten_of_hearts, jack_of_hearts, eight_of_hearts, nine_of_hearts]

      assert_equal -1, straight_flush <=> royal_flush
      assert_equal 0, royal_flush <=> royal_flush
      assert_equal 1, royal_flush <=> straight_flush
    end
  end
end
