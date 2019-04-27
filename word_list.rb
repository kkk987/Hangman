require 'yaml'
#require_relative 'game.rb'

# Hangman - Word_List class 
# Created on 27/04/2019
# - Initialize the word list
# - Attributes: word list, secret word
# - Behabiors: generate a secret
#

class Word_List #< Game
    attr_reader :secret_word
    def initialize
        #load a defualt word array from a yaml file 
        @word_list = YAML.load(File.read("word_list.yml"))

    end
    def gen_sercret_word
        #randomly pick a word from word list
        @secret_word = @word_list.sample
        return @secret_word
    end
end