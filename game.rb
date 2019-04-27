# Hangman - Game class 
# Created on 25/04/2019
# - Initialize the game setting
# - Attributes: 
# - Behabiors: check if game finished, display game interface, 
#              show help menu

require_relative 'word_list.rb'
require_relative 'player.rb'

NEW_GAME = 1
HELP_MENU = 5
QUIT = 6 
INVALID_MENU_CMD = 1

class Game
    def initialize
        @gameover = false
    end
    #show game menu
    def dispaly_menu
        puts "Hangman game"
        puts "Menu: (Please enetr a number from 1 to 6)"
        puts "1. New game"
        puts "5. Help / How to play"
        puts "6. Quit"
    end
    #get menu command from player
    def get_cmd
        
        begin
            puts "1st gets"
            @cmd = gets.chomp
            @cmd = Integer(@cmd)
        rescue
            error_msg(INVALID_MENU_CMD)
        end
    end

    def cmd_option
        puts "\e[H\e[2J"
        case
            when @cmd == NEW_GAME 
                game_start
            when @cmd == HELP_MENU
                help_menu
            when @cmd == QUIT
                #return nil
                puts @gameover
                return quit_game
                #return @gameover
                #puts @gameover
            else
                error_msg(INVALID_MENU_CMD)
        end
        
    end

    #load a new secret word
    def game_start
        word_list = Word_List.new
        player = Player.new
    end

    #Check if game is finished
    # 2 situations finish the game: 
    #  - correctly guess the secret word
    #  - guess chances is zero
    #  - -q is entered
    def gameover?
        
    end
    #explain the game rules and availbe commands
    def help_menu
        puts "How to play"
        puts "Player needs to guess a secret word"
        puts "Player can enter a letter each turn"
        puts "The letter will be filled in blank if the letter is correct"
        puts "Otherwise, player will lose 1 guess chance and the game will draw part of hangman"
        puts "Player has 5 guesses in a game"
        puts "If that reaches 0, the game is over"
        puts "By entering -q, player can quit game duing a game session"
        puts "Press any keys to continue...."
        puts "2nd gets"
        continue = gets.chomp
    end
    #quit the game
    def quit_game
        @gameover = true
        return @gameover
    end
    #all error messages are put here
    def error_msg(err_type)
        case
            when err_type == INVALID_MENU_CMD
                puts "Please enter an integer from 1 to 6"
                #dispaly_menu
            #else 

        end
        puts "Press any keys to continue...."
        puts "3rd gets"
        continue = gets.chomp
    end
    
end
game = Game.new
loop do
    puts "\e[H\e[2J"
    game.dispaly_menu
    game.get_cmd
    if game.cmd_option == true
        puts "break"
        break
    end
end
