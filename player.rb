# Hangman - Player class 
# Created on 27/04/2019 
# - Initialize the player setting
# - Attributes: player nickname, guess chances, 
#               words player has guessed
# - Behabiors: make a guess

class Player
    attr_reader :guesses
    def initialize
        @player = "unknown player"
        @guesses = 5
        @guessed_word = []
    end

    def make_guess
        guess = gets.chomp.to_s
        return guess
    end
end