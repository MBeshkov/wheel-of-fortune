# wheel-of-fortune
Ruby Web Development Project

Originally created in 2019.

### Setup
1. Download zip file
2. Extract folder in a preferred location
3. Open command line prompt window
4. Navigate to the location of the “wof.rb” file
5. Type in “ruby wof.rb”
6. Wait for the app to boot up
7. Open a browser and navigate to https://localhost:4567
- Recommended to keep sound on as web app has audio autoplay features

### Description and features

#### A game of Wheel of Fortune works as follows:
1. The program generates a phrase from a specified file and displays a template 
consisting of special characters equal to the length of the phrase.
2. The user attempts to guess the secret phrase, one letter at a time. If he or she 
guesses correctly, all instances of the letter in the template appear on their 
corresponding positions. If the guess is incorrect, the number of remaining 
attempts the user has decrements by one and they get auditory/visual 
feedback related to their mistake (in this case a man’s body parts gradually 
appearing on the gallows akin the popular game “hangman”). Additionally, the 
user can attempt to guess the whole word at once, but they automatically lose 
the game if the guess is incorrect.
3. The game ends either when all the letters have been guessed correctly (win) or 
when the user has used all their 6 chances for an incorrect attempt (lose).

#### Main features of the web application:
1. Game 
2. Rules 
3. Credits
4. Analysis 
5. Signup and Login

#### Sub-features of the web application:

1. Record of already attempted letters when in game
2. Validation of input when in game
3. Scoreboard
4. Record of user activity
5. Database connectivity
6. Musical cues
7. Animated feedback
8. A stylish look and feel

### Instructions

#### Home/Main Menu

1. “Give me a challenge!” → Start new game
2. “What do I have to do?” → See the rules
3. “Who are you, anyway?” → Credits/About me
4. “Can you analyse me?” → Scoreboard and user 
activity

#### Game screen

1. Feedback illustration in hangman 
style
2. Hidden word – how many letters the 
user has to guess
3. Field for input and button for 
submission
4. List of already attempted letters
5. Number of mistakes
6. Quit to main menu

#### Analyse page

1. Scoreboard – number of times user guessed the word correctly or failed to do so
2. User activity – what the user did while using the app in chronological order. Legend:
- “You enjoyed the scenery for a while” – user visited home page
- “You attempted to save your friend” – user played a game
- “You tried to understand the rules of this twisted affair” – user visited the rules page
- “You were curious about the creator” – user visited the credits page
- “You checked if you are as good as you think you are” – user visited the analysis page
