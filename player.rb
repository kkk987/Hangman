# Hangman - Player class 
# Created on 27/04/2019 
# - Initialize the player setting
# - Attributes: player nickname, guess chances, 
#               words player has guessed
# - Behabiors: make a guess
INVALID_GUESS = 3


class Player
    attr_reader :guessed_letter 
    attr_accessor :guesses
    def initialize
        @player = "unknown player"
        @guesses = 5
        @guessed_letter = " "
    end

    def make_guess
        guess = gets.chomp.to_s
        return guess
    end

    def add_guessed_letter(guess)
        #if guessed_letter.include? (guess) == false
            guessed_letter << guess
            return guessed_letter
             
    end
end