module Poker
  # Represents a hand of cards in Poker
  class Hand
    # Ranks of poker hands
    SCORES = %i(
      high_card one_pair two_pair three_of_a_kind straight flush full_house four_of_a_kind straight_flush royal_flush
    )

    # [Array] of [Card]s in [Hand]
    attr_reader :cards

    # @param hands [Array] All of the [Hand]s you want to compare
    # @return [Hand] The winning hand
    def self.best hands
      hands.sort.last
    end

    # A poker hand
    #
    # @param cards [Array] All of the [Card]s in the [Hand]
    def initialize cards
      @cards = cards.sort
    end

    # @return [Card] Highest card in the hand
    def highest_card
      cards.last
    end

    # @return [Integer] Value index of the highest card in the scored hand or the highest "high card" index
    def highest_card_index_scored
      duplicates.keys.sort.last || highest_card.value_index
    end

    # @return [Array] Suits in the [Hand]
    def suits
      cards.map(&:suit).uniq
    end

    # Compares two [Hand]s
    #
    # @param other_hand [Hand] Right side hand to compare to this hand
    # @return [Integer] `-1` if this is the winning hand, `0` if it's a draw and `1` if the `other_hand` is
    #   the winning hand.
    def <=> other_hand
      if score_index < other_hand.score_index
        -1
      elsif score_index > other_hand.score_index
        1
      else
        highest_card_index_scored <=> other_hand.highest_card_index_scored
      end
    end

    # @return [Symbol] Score of hand (e.g. `:full_house`)
    # @see SCORES
    def score
      SCORES.reverse.map { |score| break score if send score }
    end

    # Used for comparing two [Hand]s
    #
    # @return [Integer] Index of the score
    def score_index
      SCORES.index score
    end

    private

    def high_card
      true
    end

    def one_pair
      duplicates.values == [2]
    end

    def two_pair
      duplicates.values == [2, 2]
    end

    def three_of_a_kind
      duplicates.values == [3]
    end

    def straight
      cards.each_cons(2).all? { |card, next_card| next_card.value == card.next_highest_card&.value }
    end

    def flush
      suits.length == 1
    end

    def full_house
      duplicates.values.sort == [2, 3]
    end

    def four_of_a_kind
      duplicates.values == [4]
    end

    def straight_flush
      straight && flush
    end

    def royal_flush
      straight && flush && highest_card.value == 'A'
    end

    def duplicates
      @duplicates ||=
        cards
          .each_with_object(Hash.new 0) { |card, dup_count| dup_count[card.value_index] += 1 }
          .delete_if { |_, count| count == 1 }
    end
  end
end
