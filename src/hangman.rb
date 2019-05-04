require_relative 'game.rb'
# require_relative 'player.rb'
# require_relative 'word_list.rb'


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