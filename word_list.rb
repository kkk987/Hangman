require 'yaml'
#require_relative 'game.rb'

# Hangman - Word_List module
# Created on 27/04/2019
# - Behabiors: generate a secret word
#
module WordList
  def gen_secret_word
    #load a defualt word array from a yaml file
    word_list = YAML.safe_load(File.read("word_list.yml"))
    #randomly pick a word from word list
    secret_word = word_list.sample
    return secret_word.downcase
  end
end