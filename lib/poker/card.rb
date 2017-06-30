module Poker
  # Represents a single card in a hand of poker
  class Card
    # [Array] of [Card] values
    VALUES = %w(2 3 4 5 6 7 8 9 T J Q K A)

    # Alphabetically sorted [Card] suits
    SUITS = %w(C D H S)

    # @return [String] Value of the card (e.g. '2' or 'Q')
    attr_reader :value

    # @return [String] First letter of the suit of the [Card] (e.g. 'D' or 'S')
    attr_reader :suit

    # A poker card
    #
    # @param value [String] Value of the [Card] (e.g. '2' or 'Q')
    # @param suit [String] First letter of the suit of the [Card] (e.g. 'D' or 'S')
    def initialize value, suit
      raise InvalidCardValue unless VALUES.include? value.to_s.upcase
      @value = value.upcase
      @suit = suit.upcase
    end

    # Compares two [Card]s
    #
    # @param other_card [Card] Right side card to compare to this card
    # @return [Integer] `-1` if this is the higher card, `0` if it's a draw and `1` if the `other_card` is
    #   the higher card.
    def <=> other_card
      value_index <=> other_card.value_index
    end

    # Used for comparing two [Card]s
    #
    # @return [Integer] Index of the card value
    def value_index
      VALUES.index value
    end

    # @return [Card] The next highest [Card] of same suit (e.g. a 3S if this [Card] is a 2S)
    # @return [nil] if this [Card] is an Ace
    def next_highest_card
      self.class.new VALUES[value_index + 1], suit
    rescue Poker::InvalidCardValue
      # Return nil if current card is an Ace
    end
  end
end
