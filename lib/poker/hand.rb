module Poker
  class Hand
    SCORES = %i(
      high_card one_pair two_pair three_of_a_kind straight flush full_house four_of_a_kind straight_flush royal_flush
    )

    attr_accessor :cards

    def self.best hands
      hands.sort.last
    end

    def initialize cards
      @cards = cards.sort
      @score = score
    end

    def highest_card
      cards.last
    end

    def highest_card_index_scored
      duplicates.keys.sort.last || highest_card.value_index
    end

    def suits
      cards.map(&:suit).uniq
    end

    def <=> other_hand
      if score_index < other_hand.score_index
        -1
      elsif score_index > other_hand.score_index
        1
      else
        highest_card_index_scored <=> other_hand.highest_card_index_scored
      end
    end

    def score
      SCORES.reverse.map { |score| break score if self.public_send score }
    end

    def score_index
      SCORES.index score
    end

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

    private

    def duplicates
      @duplicates ||=
        cards
          .each_with_object(Hash.new 0) { |card, dup_count| dup_count[card.value_index] += 1 }
          .delete_if { |_, count| count == 1 }
    end
  end
end
