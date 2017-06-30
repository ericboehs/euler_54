module Poker
  class Card
    VALUES = %w(2 3 4 5 6 7 8 9 T J Q K A)
    SUITS = %w(C D H S)

    attr_accessor :value, :suit

    def initialize value, suit
      @value = value.upcase
      @suit = suit.upcase
    end

    def <=> other_card
      value_index <=> other_card.value_index
    end

    def value_index
      VALUES.index value
    end

    def next_highest_card
      self.class.new VALUES[value_index + 1], suit
    end
  end
end