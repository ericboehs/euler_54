require_relative '../../lib/poker'
require 'minitest/autorun'

module Poker
  class CardTest < MiniTest::Test
    def ace_of_spades
      Poker::Card.new 'a', 's'
    end

    def nine_of_hearts
      Poker::Card.new '9', 'h'
    end

    def test_invalid_card
      assert_raises Poker::InvalidCardValue do
        Poker::Card.new '14', 'h'
      end
    end

    def test_card_value
      assert_equal '9', nine_of_hearts.value
      assert_equal 'A', ace_of_spades.value
    end

    def test_card_value_index
      assert_equal 7, nine_of_hearts.value_index
      assert_equal 12, ace_of_spades.value_index
    end

    def test_card_comparison
      assert_equal -1, nine_of_hearts <=> ace_of_spades
      assert_equal 0, ace_of_spades <=> ace_of_spades
      assert_equal 1, ace_of_spades <=> nine_of_hearts
    end
  end
end
