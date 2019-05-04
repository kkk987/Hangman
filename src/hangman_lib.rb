module CommonMethods
  #show game menu
  def dispaly_menu
    puts "Hangman game"
    puts "Menu: (Please enetr a number from 1 to 6)"
    puts "1. New game"
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
end