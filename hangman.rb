require_relative 'game.rb'
require_relative 'player.rb'
require_relative 'word_list.rb'




game = Game.new

loop do
    puts "\e[H\e[2J"
    game.dispaly_menu
    game.get_cmd
    if game.cmd_option == GAMEOVER
        puts "break"
        break
    end
end