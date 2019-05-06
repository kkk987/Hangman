# Hangman - leaderboard module
# Created on 05/05/2019
# This file includes methods relaated to leaderboard
# It supports functionalities like:
#   - display the leaderboard
#   - load the existing leaderboard
#   - create a new leaderborad
#   - save the ranks

require 'terminal-table'
require 'yaml'

module Leaderboard
  def display_ranks(ranks)
    table = Terminal::Table.new :title => "Leaderboard", :headings => ['Rank', 'Name', 'Time'], :rows => ranks, :style => {:width => 80}
    table.align_column(0, :left)
    table.align_column(1, :left)
    table.align_column(2, :right)
    puts table
  end
  
  def save_ranks(ranks)
    # puts "Ranks #{ranks}"
    ranks = ranks.sort_by {|item| item[:time]}
    # puts "After sort #{ranks}"
    while ranks.length > 10 do
      ranks.pop
    end
    File.write('ranks.yml', ranks.to_yaml)
    puts "Save rank complete"
  end
  
  def load_ranks
    ranks = []
    ranks = YAML.load(File.read("ranks.yml"))
    puts "Load rank complete"
    return ranks
  end  

  def load_table(ranks)
    i = 1
    table = []
    ranks.each do |item|
      time = Time.at(item[:time]).utc.strftime("%H:%M:%S")
      table << [i, item[:name], time]
      i += 1
    end
    # puts "Table: #{table}"
    return table
  end
end

