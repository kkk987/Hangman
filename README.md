# README
Gen tech terminal app

* Github repository link

https://github.com/kkk987/Hangman.git

# App Description:
 * Purpose:
    
    This is a hangman game app. The player can guess a secret word from the terminal. The more wrong guesses the more pieces of hangman will be drawn.
 * Functionality:
    
    This app currently enables to do the followings:
  
    * Generate a random secret word 
    * Display the hangman game menu
    * Player can guess the secret with limited guesses
    * User input validation
    * Hangman drawing
    * Display help menu
    * Start a new game
    * Quit game
    * Add a new word in word list (updated)
    * View leaderboard (updated)
    * Add new rankings if it is within top 10(updated)

* Instruction for use:
    
  gem install bundler

  ruby hangman.rb

* Future enhancements:
    
  * ~~Add a new word~~ (completed)
  * Save/load a game
  * Game settings(such as font, font size, color etcs)
  * ~~Leader board~~ (completed)
  * Sound while playing hangman
  * Human VS human mode

* Accessibility concerns:

    As for users who are visionimpaired, only black and white are used as font colors for this app. And as a future features, text setting can be more user friendly and provide more accessinilities. 

* Potential legal, moral, ethical, cultural and safety issues:

    Young players may experience uncomfortableness towards the hangman drawings. And some of the secret words may be offensive to a certain group of people.
    As a solution, a disclaim page will be added as a future enhancement. And possible offensive words will be reassessed before adding into a word list.

* Possible social, political, cultural, racial, gender and international issues:
    Some of the secret words may be offensive to certain social, political, cultural, racial, gender and international groups. These words will be assessed before adding into world lists.
# Design and Planning:
* Evidence of app idea brainstorming sessions:
    
    Hangman game is the topic of this terminal app. The reasons to pick hangman are that:
    - a good opportunity to practice the input validation
    -  learn how to use class and module
    -  learn how to write dry codes
    -  and plenty of advanced features for future development

* User stories:

    - US -1: As a user, I can guess a word
    - US - 2: As a user, I can see the chances left
    - US - 3: As a user, I know what letters I guessed
    - US - 4: As a user, I know which letter I guessed is correct
    - US - 5: As a user, I can restart the game when I finish one
  
* Project plan and timeline:

  - ![timeline_1](https://user-images.githubusercontent.com/8579501/57189376-75bf0d80-6f51-11e9-950b-fd67bcf734e0.PNG "Time line part 1")


  - ![timeline_2](https://user-images.githubusercontent.com/8579501/57189393-a010cb00-6f51-11e9-92ba-c7bee47e3849.PNG "Time line part 2")

  
* Description of overall app design (classes, files, basic flow):

    hangman: 
    
    This is the main file where runs all related programs. 

    Class - game: 
    
    The game class is the framework of the whole game. This class responses to basic game mechanisms such as display menu and corresponding reactions, initialize other classes, check game over status and quit the game.
    
    Class - player: 
    
    The player class stores all user information and behaviors. At this stage, there are not much attributes and behaviors are stored in this class. But it will provide extra flexibility when considering future developments which involve players such as leader board or save/load a game

    Module - Word list: 
    
    The word list module stores methods that are related to word processing such as generate a secret and add a new word. This is listed as a separated file for the same reason as player class's which provides more flexibility for future features.

    Module - Hangman lib: 
    
    This file contains some commonly called methods which are easier for maintenance and debugging purposes.

    Module - Hangman art: 
    
    This file contains the ASCII art of hangman. This file is supposed to be part of the game class, however, it will make a single class file too big. And considering some future features like difficulty setting (each difficulty has a different guess chance at the start), it is separated as an individual file.

    Module - Leaderboard: 

    This file contains the functionalities such as sav/load ranks and display leaderboard. And the 'terminal table' gem is used to support the visulization of leaderboard. 

    Class - Hangman test: 
    
    This file includes all testing for main program. It is separated so that it is more editable and readable for the programmer.

    Yaml file - Word list: 
    
    This is the default word list where provides a list of secret words for players to guess.

    Yaml file - ranks:

    This is where the game saves all rankings. It is separeated so that the rankings can be independent from the game.

    Flowchart:
    - ![flowchart_1](https://user-images.githubusercontent.com/8579501/57189401-c0d92080-6f51-11e9-85aa-21fe796675d2.jpg "FLowchart part 1")
    - ![flowchart_2](https://user-images.githubusercontent.com/8579501/57189411-d6e6e100-6f51-11e9-84af-3932aa2037fd.jpg "Flowchart part 2")


* Design considerations and choices:
    
    There are a couple of choices when first design hangman game. One of the alternatives is to use a gem called "gosu" which is a gem specializing in games as the game framework. However, a gem normally contains many other functionalities that are not necessary for the project and may increase the difficulty in debugging. Therefore the final design is to write an individual class that holds the basic framework of the game which is easier for debugging purpose and editing. 


* Screenshots of Trello board(s):
    - ![trello_board](https://user-images.githubusercontent.com/8579501/57189417-ebc37480-6f51-11e9-9cb4-0e16d22f977a.PNG "Trello board")



