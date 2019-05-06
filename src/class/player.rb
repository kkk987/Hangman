# Hangman - Player class
# Created on 27/04/2019
# - Initialize the player setting
# - Attributes: player nickname, guess chances,
#               words player has guessed
# - Behabiors: make a guess
DEFAULT_GUESSES = 5
DEFAULT_NAME = "unknown player"
DEFAULT_LETTERS = " "

class Player
  attr_reader :guessed_letter
  attr_accessor :guesses
  def initialize
    @name = DEFAULT_NAME
    @guesses = DEFAULT_GUESSES
    @guessed_letter = DEFAULT_LETTERS
  end

  def new_game_init
    @name = DEFAULT_NAME
    @guesses = DEFAULT_GUESSES
    @guessed_letter = " "
  end

  def make_guess
    guess = gets.chomp.to_s
    return guess.downcase
  end

  def add_guessed_letter(guess)
    @guessed_letter << guess
    return @guessed_letter
  end

  def get_player_name
    puts "Please enter your name"
    @name = gets.chomp.to_s
    if (@name.nil?) || (@name.empty?)
      @name = DEFAULT_NAME
    end
    return @name
  end
end