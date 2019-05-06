# Hangman - hangman
# Created on 01/05/2019
# - Initialize the game
# - Runs the whole game

require_relative './class/game.rb'

game = Game.new

loop do
  game.clear_screen
  game.dispaly_menu
  game.get_cmd
  game_status = game.cmd_option
  if game_status == QUIT
    break
  elsif game_status != GAME_CONTINUE
    game.continue_prompt
  end
end