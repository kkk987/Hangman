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
INVALID_MENU_CMD = 7
INVALID_QUIT = 8
INVALID_GUESS = 9
GAMEOVER = true
GAME_CONTINUE = false

class Game
    def initialize
        #@gameover = false
        # @player = Player.new
        # @secret_word = WordList.gen_secret_word
        # @status = GAME_CONTINUE
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
            #puts "1st gets"
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
    def game_start
        word_list = Word_List.new
        player = Player.new
        status = GAME_CONTINUE
        secret_word = word_list.gen_secret_word.downcase
        word_list.count_uniq_char
        # puts "Test to see remaint guesses"
        # puts player.guesses
        puts "Here is the secret word"
        puts word_list.secret_word
        loop do
            puts "\e[H\e[2J"
            display_game(secret_word, player.guessed_letter.to_s, player.guesses)
            guess = player.make_guess
            # puts "player guessed letter"
            # puts player.guessed_letter
            # puts "Here is guess"
            # puts guess
            status = guess_check(guess, player.guessed_letter)
            # puts "status after guess check"
            # puts status
            error_msg(status)
            if status == GAME_CONTINUE
                if (secret_word.include? (guess)) == true
                    puts "Your guess is correct!"
                    word_list.win_flag -= 1
                else
                    puts "Sorry your guess is wrong :/."
                    player.guesses -= 1
                end
                player.add_guessed_letter(guess)
    
            end
            sleep(1)

            break if gameover?(player.guesses, word_list.win_flag, status, secret_word) == GAMEOVER  
        end
        # puts "status:"
        # puts status
        #check if player wants to quit
        return QUIT if status == QUIT
        #back to main menu
        return GAMEOVER


    end
    #display the secret word
    ##### Add hangman drawing here
    def display_game(word, guessed_letter, guesses)
        puts word.tr('^' + guessed_letter, '_').chars.join(' ')
        puts "You have #{guesses} guesses left"
        puts "Here is what you guessed:#{guessed_letter}"
        puts "Please enter a letter"
    end

    def guess_check(guess, guessed_letter)
        #an input more 2 characters is invalid
        # puts "Guess length:"
        # puts guess.length
        return INVALID_GUESS if guess.length > 2
        case
            when guess.length == 2
                if (guess.include?("-") == false) || (guess.include?("q") == false)
                    return INVALID_QUIT
                elsif guess == "-q"
                    return QUIT
                else
                    return INVALID_GUESS
                end
                # case
                # when guess.include? ("-") == false || guess.include? ("q") == false
                #     return INVALID_QUIT
                # when guess == "-q"
                #     return QUIT
                # else
                #     return INVALID_GUESS
                # end
                # (guess == "-q") ? (return QUIT) : (return INVALID_QUIT)
            when guess.length == 1
                return INVALID_GUESS if (guess =~ /[[:alpha:]]/) != 0
                return INVALID_GUESS if guessed_letter.include?(guess) == true
                return GAME_CONTINUE
            else
                return INVALID_GUESS
        end
    end



    #Check if game is finished
    # 2 situations finish the game: 
    #  - correctly guess the secret word
    #  - guess chances is zero
    #  - -q is entered
    def gameover?(guesses, win_flag, status, secret_word)


        if guesses == 0 
            puts "Gameover!! Better luck next time!!"
            puts "The word is #{secret_word}"
            return GAMEOVER
        elsif win_flag == 0
            puts "Congraduation!! You won the game!!"
            return GAMEOVER
        elsif status == QUIT
            puts "You sure you want to quit game? Please enter -q again"
            cmd = gets.chomp.to_s
            if cmd == "-q"
                return GAMEOVER
            else
                return GAME_CONTINUE    
            end
        else
            return GAME_CONTINUE
        end
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
        # puts "Press any keys to continue...."
        # puts "2nd gets"
        # continue = gets.chomp
        return HELP_MENU
    end
    #quit the game
    def quit_game
        #@gameover = true
        return QUIT
    end

    def continue_prompt
        puts "Press enter key to continue...."
        #puts "3rd gets"
        continue = gets.chomp
    end

    #all error messages are put here
    def error_msg(err_type)
        case
            when err_type == INVALID_MENU_CMD
                puts "Please enter an integer from 1 to 6"
                #dispaly_menu
                #continue_prompt
            when err_type == INVALID_QUIT
                puts "Please enetr -q to quit game"
                #continue_prompt
            when err_type == INVALID_GUESS
                puts "Please enter a new single letter"
                #continue_prompt
            else
                return GAME_CONTINUE
        end
        
    end
    
end
game = Game.new

loop do
    puts "\e[H\e[2J"
    game.dispaly_menu
    game.get_cmd
    game_status = game.cmd_option
    if game_status == QUIT
        #puts "break"
        break
    elsif game_status != GAME_CONTINUE
        game.continue_prompt
    end
end
