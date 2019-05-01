# Hangman test
# This file uses test unit to test some methods in the other files
# Corner case are used as input to test the method
# Author: Mark Ying
# Created on: 1/5/2019

require 'test/unit'
require_relative 'game.rb'

class HangmanTest < Test::Unit::TestCase
  def test_error_msg
    assert_equal(INVALID_MENU_CMD, Game.new.error_msg(INVALID_MENU_CMD))
    assert_equal(INVALID_QUIT, Game.new.error_msg(INVALID_QUIT))
    assert_equal(INVALID_ERR_TYPE, Game.new.error_msg([GAME_CONTINUE, QUIT]))
    assert_equal(INVALID_ERR_TYPE, Game.new.error_msg("Hello"))
  end
  def test_guess_check
    num_input = 10000000000000
    randon_input = "-+!@@~`\\`"
    assert_equal(INVALID_GUESS, Game.new.guess_check(num_input))
    assert_equal(INVALID_GUESS, Game.new.guess_check(randon_input))
    assert_equal(QUIT, Game.new.guess_check('-q'))
    assert_equal(INVALID_QUIT, Game.new.guess_check('-a'))
    assert_equal(GAME_CONTINUE, Game.new.guess_check('A'))
    assert_equal(INVALID_GUESS, Game.new.guess_check('1'))
  end
  def test_add_guessed_letter
    assert_equal(" a", Player.new.add_guessed_letter("a"))
  end
end








