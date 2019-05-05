require 'terminal-table'
require 'yaml'

module CommonMethods
  #show game menu
  def dispaly_menu
    puts "Hangman game"
    puts "Menu: (Please enetr a number from 1 to 6)"
    puts "1. New game"
    puts "4. Leaderboard"
    puts "5. Help / How to play"
    puts "6. Quit"
  end
  def clear_screen
    puts "\e[H\e[2J"
  end
  #get an enter key from player to continue the game
  def continue_prompt
    puts "Press enter key to continue...."
    continue = gets.chomp
  end

  def set_timer
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    return starting
  end

  def finish_timer
    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    return ending
  end

  def display_time(start, finish)
    puts "Time used: " + Time.at(finish - start).utc.strftime("%H:%M:%S")
  end

  #check if a given file exits
  #if the file doesn't exist, create a new file
  def check_file_exist(_Filename)
    unless File.exist?("#{_Filename.to_s}.yml")
        File.open("#{_Filename.to_s}.yml", 'w')
    end
  end

end