# Hangman - Word_List module
# Created on 27/04/2019
# - Behabiors: load word list, generate a secret word
# add a new word, check duplicates in word list

require 'yaml'

INVALID_NEW_WORD = 10
GAME_CONTINUE = false

module WordList
  # load a defualt word array from a yaml file
  def load_word_list
    word_list = YAML.safe_load(File.read("word_list.yml"))
    return word_list
  end
  
  # randomly pick a word from word list
  def gen_secret_word(word_list)
    secret_word = word_list.sample
    return secret_word.downcase
  end

  # check if new word exists in word list
  def duplicate_word_check?(word_list, word)
    if word_list.include? word.capitalize
      return false # duplicate found
    else
      return true # no duplicates
    end
  end

  # check if new word consists of letters
  def is_letter?(word)
    if word[/[a-zA-Z]+/] == word
      return true
    else
      return false
    end
  end

  # allow player to add a new word in default word list
  def add_new_word(word_list)
    puts "Please enter the word you want to add"
    new_word = gets.chomp.to_s
    flag_1 = duplicate_word_check?(word_list, new_word)
    flag_2 = is_letter?(new_word)
    # check if both flags pass
    if flag_1 & flag_2
      word_list << new_word.capitalize
      word_list = word_list.sort
      File.write("word_list.yml", word_list.to_yaml)
      puts "New word is added"
      return GAME_CONTINUE
    else
      return INVALID_NEW_WORD
    end
  end
end