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
INVALID_QUIT = 2
INVALID_GUESS = 3
GAMEOVER = true
GAME_CONTINUE = false

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
                return game_start
            when @cmd == HELP_MENU
                help_menu
            when @cmd == QUIT
                #return nil
                #puts @gameover
                return quit_game
                #return @gameover
                #puts @gameover
            else
                error_msg(INVALID_MENU_CMD)
        end
        
    end


    

    #load a new secret word
    def game_start()
        word_list = Word_List.new
        player = Player.new
        word_list.gen_secret_word
        word_list.count_uniq_char
        puts "Test to see remaint guesses"
        puts player.guesses
        puts "Here is the secret word"
        puts word_list.secret_word
        loop do
            display_game(word_list.secret_word, player.guessed_letter.to_s, player.guesses)
            guess = player.make_guess.downcase
            puts "player guessed letter"
            puts player.guessed_letter
            puts "Here is guess"
            puts guess
            error_msg(guess_check(guess, player.guessed_letter)) 
            if (word_list.secret_word.downcase.include? (guess)) == true
                puts "Your guess is correct!"
                word_list.win_flag -= 1
            else
                puts "Sorry your guess is wrong :/."
                player.guesses -= 1
            end
            player.add_guessed_letter(guess)


            break if gameover?(player.guesses, word_list.win_flag) == GAMEOVER  
        end
        return GAMEOVER


    end
    #display the secret word
    ##### Add hangman drawing here
    def display_game(word, guessed_letter, guesses)
        puts word.tr('^' + guessed_letter, '_').chars.join(' ')
        puts "You have #{guesses} guesses left"
        puts "Here is what you guessed: #{guessed_letter}"
        puts "Please enter a letter"
    end

    def guess_check(guess, guessed_letter)
        #an input more 2 characters is invalid
        return INVALID_GUESS if guess.length > 2
        case
            when guess.length == 2
                (guess == "-q") ? (return @gameover = true) : (return INVALID_QUIT)
            when guess.length == 1
                return INVALID_GUESS if (guess =~ /[[:alpha:]]/) != 0
                return INVALID_GUESS if guessed_letter.include?(guess) == true

            else
                return INVALID_GUESS
        end
    end



    #Check if game is finished
    # 2 situations finish the game: 
    #  - correctly guess the secret word
    #  - guess chances is zero
    #  - -q is entered
    def gameover?(guesses, win_flag)


        if guesses == 0 
            return GAMEOVER
        elsif win_flag == 0
            return GAMEOVER
        end

        return GAME_CONTINUE
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

    def continue_prompt
        puts "Press any keys to continue...."
        puts "3rd gets"
        continue = gets.chomp
    end

    #all error messages are put here
    def error_msg(err_type)
        case
            when err_type == INVALID_MENU_CMD
                puts "Please enter an integer from 1 to 6"
                #dispaly_menu
                continue_prompt
            when err_type == INVALID_QUIT
                puts "Please enetr -q to quit game"
                continue_prompt
            when err_type == INVALID_GUESS
                puts "Please enter a new single letter"
                continue_prompt
            else

        end
        
    end
    
end
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
