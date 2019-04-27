# Hangman - Player class 
# Created on 27/04/2019 
# - Initialize the player setting
# - Attributes: player nickname, guess chances, 
#               words player has guessed
# - Behabiors: make a guess

class Player
    attr_reader :guessed_letter
    attr_accessor :guesses
    def initialize
        @player = "unknown player"
        @guessed_letter = []
    end

    def make_guess
        guess = gets.chomp.to_s
        return guess
    end
end