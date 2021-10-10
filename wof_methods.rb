require 'sinatra'


  module WOFMethods
    def start                                                                                         # INITIAL GAME STATE
      session[:phrase] = some_phrase                                                                  # takes a random word from the wordfile, using method 5)
      session[:mistakes] = 0                                                                          # sets wrong guesses to 0
      session[:guesses] = []                                                                          # array for storing attempted letters
      session[:warning] = ''                                                                          # warning in case of invalid input
      session[:template] = session[:phrase].gsub(/./, '_')                                            # hangman-styled template
    end

    def game(guess) # 1)                                                                            # "CONTAINER"/INITIALIZER FOR MAIN GAME BEHAVIOUR
      if good_attempt?(guess)                                                                         # Initiates game behaviour if input is valid (checked by method 8)
        new_state(guess)
      else
        session[:warning] = 'Stop giving me nonsense or repeating letters! >:c'                       # Displays a warning message if input is not valid (checked by method 8)
      end
    end

    def new_state(guess) # 2)                                                                         # MAIN GAME BEHAVIOUR
      if guess.length == 1                                                                            # Behaviour if user attempts to guess a single letter
        session[:guesses].push(guess)                                                                 # Store the letter in the array with the attempted letters
        session[:mistakes] = mistakes + 1 unless a_match?(guess)                                      # Increases number of mistakes if the letter isn't in the word (checked by method 4)
        update_template(guess) if a_match?(guess)                                                     # Updates template (method 3) if the letter is in the word (checked by method 4)
      else                                                                                            # Behaviour if user attempts to guess the whole word at once
        session[:mistakes] = 6                                                                        # Max out number of mistakes as the rules of the game don't permit further play in case the user tries to guess the word at once
        session[:template] = phrase if guess == phrase                                                # Remove template if guess was correct (for display purposes in method 9)
      end
    end

    def update_template(guess) # 3)                                                                   # TEMPLATE SCANNER
      positions = (0...phrase.length).find_all { |p| phrase[p] == guess }                             # Updates hangman-styled template with matches from the user by searching for letters that match and what their positions are
      positions.each { |position| session[:template][position] = phrase[position] }
    end

	  def a_match?(guess) # 4)                                                                            # CHECKS IF THE USER GUESS MATCHES A LETTER IN THE SECRET WORD
      phrase.split('').include?(guess)
    end

    def some_phrase # 5)                                                                              # SETS A NEW WORD...
      phrase = ''
      phrase = create_phrase                                                                        # ...by taking a random word from the word file, using method 6)
      phrase                                                                                          # Returns said word
    end

    def create_phrase # 6)                                                                          # TAKES A RANDOM WORD FROM ARRAY GENERATED IN METHOD 7)
      phrases_collection[rand(phrases_collection.length - 1)].upcase
    end

    def phrases_collection # 7)                                                                       # GENERATES AN ARRAY WITH ALL WORDS FROM WORD FILE
      every_phrase = File.open('./wordfile.txt', 'r', &:readlines)
      every_phrase.map!(&:strip)
    end

	  def good_attempt?(guess) # 8)                                                                       # VALIDATION OF INPUT
      !guesses.include?(guess) && !guess.empty?                                                         # Input only valid if not empty and not already attempted
    end

    def reveal_secret # 9)                                                                            # FULLY DISPLAYS ORIGINAL WORD (FOR USE IN DIFFERENT END STATES/VIEWS)
      reveal = template.gsub(/./) { |symb| symb + '   ' }
      reveal.strip
    end

    def picture # 10)                                                                                 # DISPLAYS REQUIRED IMAGE DEPENDING ON TURNS LEFT
      pic = "img/feedback#{mistakes}.svg"
      pic = 'img/feedback_win.png' if successful?                                                      # Displays win state image if word is guessed correctly
      pic
    end

	  def fail? # 11)                                                                                    # DEFINES THE LOSE STATE...
      mistakes == 6 && template != phrase                                                             # ...namely when user has no turns left and the updated template is still different than the secret word
    end

    def successful? # 12)                                                                              # DEFINES THE WIN STATE...
      template == phrase                                                                               # ...namely when the updated template is the same as the secret word
    end

	  def update_wins # 13)                                                                              # INCREMENTS WIN COUNTER
		  File.open './player_count.txt' , 'r+' do |file|
		  num = file.gets.to_i
		  file.rewind
		  file.puts num.next
		  end
	  end

	  def read_wins # 14)                                                                               # READS WIN COUNTER (USED IN STATISTICS VIEW)
		  number = File.read('./player_count.txt').to_i
	  end

	  def update_loss # 15)                                                                             # INCREMENTS LOSE COUNTER
		  File.open './computer_count.txt' , 'r+' do |file|
		  num = file.gets.to_i
		  file.rewind
		  file.puts num.next
		  end
	  end

	  def read_loss # 16)                                                                              # READS LOSE COUNTER (USED IN STATISTICS VIEW)
		  number_loss = File.read('./computer_count.txt').to_i
    end

    def write_actions (action) # 17)                                                                 # RECORDS USER ACTIONS (DEFINED IN METHOD 18)
      File.open('./actions.txt', "a") do |line|
      line.puts "\r" + "you #{action} and then... "
      end
    end

	  def update_actions(option) # 18)                                                                 # DEFINES THE USER ACTIONS
      case option
      when 1
			  write_actions("enjoyed the scenery for a while")                                             # When in the main menu
		  when 2
			  write_actions("attempted to save your friend")                                               # When in the game
		  when 3
			  write_actions("tried to understand the rules of this twisted affair")                        # When in the rules page
		  when 4
			  write_actions("checked if you are as good as you think you are")                             # When in the statistics page
		  when 5
			  write_actions("were curious about the creator")                                              # When in the creator page
		  end
	  end

	  def read_actions # 19)                                                                           # READS USER ACTIVITY (USED IN STATISTICS VIEW)
		  action_list = File.read('./actions.txt')
	  end

	  def phrase # 20)                                                                                 # TOGETHER WITH METHODS 20)...24) RETURNS RELEVANT UPDATED DATA AND STORES "COOKIES"
      session[:phrase]
    end

    def guesses # 21)
      session[:guesses]
    end

    def mistakes # 22)
      session[:mistakes]
    end

    def warning # 23)
      session[:warning]
    end

    def template # 24)
      session[:template]
    end

  end

	helpers WOFMethods

