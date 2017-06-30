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
      @cards = cards
      @score = score
    end

    def highest_card
      cards.sort.last
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
      SCORES.reverse.map do |score_to_check|
        score = self.public_send score_to_check
        break score if score
      end
    end

    def score_index
      SCORES.index score
    end

    def high_card
      :high_card
    end

    def one_pair
      :one_pair if duplicates.count == 1 && duplicates.values == [2]
    end

    def two_pair
      :two_pair if duplicates.count == 2 && duplicates.values == [2, 2]
    end

    def three_of_a_kind
      :three_of_a_kind if duplicates.count == 1 && duplicates.values == [3]
    end

    def straight
      :straight if succession?
    end

    def flush
      :flush if suits.length == 1
    end

    def full_house
      :full_house if duplicates.count == 2 && duplicates.values.sort == [2, 3]
    end

    def four_of_a_kind
      :four_of_a_kind if duplicates.count == 1 && duplicates.values == [4]
    end

    def straight_flush
      :straight_flush if straight && flush
    end

    def royal_flush
      :royal_flush if straight && flush && cards.sort.last.value == 'A'
    end

    private

    def duplicates
      cards
        .each_with_object(Hash.new 0) { |card, hash| hash[card.value_index] += 1 }
        .delete_if { |_, count| count == 1 }
    end

    def succession?
      cards.sort.map(&:value_index).each_cons(2).all? { |card, next_card| next_card == card + 1 }
    end
  end
end
