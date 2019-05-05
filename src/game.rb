#Hangman - Game class
# Created on 25/04/2019
# - Initialize the game setting
# - Attributes:
# - Behabiors: check if game finished, display game interface,
#              show help menu

require_relative 'word_list.rb'
require_relative 'player.rb'
require_relative 'hangman_art.rb'
require_relative 'hangman_lib.rb'
require_relative './class/leaderboard.rb'
NEW_GAME = 1
LEADERBOARD = 4
HELP_MENU = 5
QUIT = 6
INVALID_MENU_CMD = 7
INVALID_QUIT = 8
INVALID_GUESS = 9
INVALID_ERR_TYPE = 10
GAMEOVER = true
GAME_CONTINUE = false

#
class Game
  include WordList
  include HangmanArt
  include CommonMethods
  include Leaderboard
  def initialize
    @player = Player.new
    #Assume the game starts normal
    @status = GAME_CONTINUE
    check_file_exist("ranks")
    @ranks = load_ranks
  end

  #get menu command from player
  def get_cmd
    begin
      @cmd = gets.chomp
      @cmd = Integer(@cmd)
    rescue
      error_msg(INVALID_MENU_CMD)
    end
  end

  #handle user commands here
  def cmd_option
    clear_screen
    case @cmd
    when NEW_GAME
      return game_start
    when HELP_MENU
      help_menu
    when LEADERBOARD
      leaderboard
    when QUIT
      return quit_game
    else
      error_msg(INVALID_MENU_CMD)
    end
  end



  #this method checks if player guessed right or wrong
  def guess_right_wrong(guess)
    if @status == GAME_CONTINUE
      if (@secret_word.include? (guess)) == true
        puts "Your guess is correct :)"
          @win_flag -= 1
      else
        puts "Sorry your guess is wrong :/"
        @player.guesses -= 1
      end
      @player.add_guessed_letter(guess)
    end
  end

  #load a new secret word
  def game_start
    #generate a secret from module WordList
    @secret_word = gen_secret_word
    #the following line counts the number of uniq char in secret word
    #win_flag is the minimum number of guesses that the player needs to guess to win the game
    @win_flag = @secret_word.split(//).uniq.length
    @player.new_game_init
    puts "Here is the secret word"
    puts @secret_word
    #get start time
    @start_time = set_timer
    loop do
      clear_screen
      display_game(@player.guessed_letter.to_s)
      guess = @player.make_guess
      #validate the input guess
      @status = guess_check(guess)
      #handle any error messages here
      error_msg(@status)
      #check if player guessed right or wrong
      guess_right_wrong(guess)
      #give time display all messages
      sleep(1)
      #check if game is over
      break if gameover? == GAMEOVER
    end
    #check if player wants to quit
    #the game only breaks when player enters -q
    return QUIT if @status == QUIT
    #back to main menu when gameover
    return GAMEOVER
  end

  #display the secret word
  #hangman drawing is put here
  def display_game(guessed_letter)   #(word, guessed_letter, guesses)
    display_hangman(@player.guesses)
    puts @secret_word.tr('^' + guessed_letter, '_').chars.join(' ')
    puts "You have #{@player.guesses} guesses left"
    puts "Here is what you guessed:#{guessed_letter}"
    puts "Please enter a letter"
  end

  #validate the input guess
  #the only valid input is a single letter or -q
  def guess_check(guess) #guessed_letter)
    #an input more 2 characters is invalid
    return INVALID_GUESS if guess.to_s.length > 2
  	case
    when guess.length == 2
      #if input includes - or q but not both
      #assume player wants to quit but enter the wrong command
      if (guess.include?("-") == false) ^ (guess.include?("q") == false)
        puts "Invalid Quit"
        return INVALID_QUIT
      elsif guess == "-q"
          return QUIT
      else
      	puts "Invalid guess"
      	return INVALID_GUESS
      end
      when guess.length == 1
        return INVALID_GUESS if (guess =~ /[[:alpha:]]/) != 0
        return INVALID_GUESS if @player.guessed_letter.include?(guess) == true
        return GAME_CONTINUE
      else
        return INVALID_GUESS
      end
  end

  def end_game_display
    clear_screen if (@status == QUIT)
    if (@player.guesses == 0)^(@win_flag == 0)
      clear_screen
      display_hangman(@player.guesses)
    end
  end

  #Check if game is finished
  # 3 situations finish the game:
  #  - correctly guess the secret word
  #  - guess chances is zero
  #  - -q is entered
  def gameover?
    end_game_display
    if @player.guesses == 0
      puts "Gameover!! Better luck next time!!"
      puts "The word is #{@secret_word}"
      return GAMEOVER
    elsif @win_flag == 0
      puts "Congraduation!! You won the game!!"
      @end_time = finish_timer
      display_time(@start_time, @end_time)
      name = @player.get_player_name
      puts "Name #{name}"
      @ranks << {name: name, time: (@end_time - @start_time).to_i}
      save_ranks(@ranks)
      return GAMEOVER
    elsif @status == QUIT
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
    return HELP_MENU
  end

  def leaderboard
    table = []
    # puts "Check existance"
    # puts "Ranks #{@ranks}"
    @ranks = load_ranks
    table = load_table(@ranks)
    display_ranks(table)
    return LEADERBOARD
  end

  #quit the game
  def quit_game
    return QUIT
  end

  #all error messages are handled here
  def error_msg(err_type)
    case
    when err_type == INVALID_MENU_CMD
			puts "Please enter an integer from 1 to 6"
			return INVALID_MENU_CMD
    when err_type == INVALID_QUIT
			puts "Please enetr -q to quit game"
			return INVALID_QUIT
    when err_type == INVALID_GUESS
			puts "Please enter a new single letter"
			return INVALID_GUESS
		when (err_type == GAME_CONTINUE) ^ (err_type == QUIT)
			return GAME_CONTINUE
		else
			puts "Invalid error message"
			return INVALID_ERR_TYPE
    end
  end
end