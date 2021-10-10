require 'sinatra'
require './wof_methods'

enable :sessions

get '/' do                         # main menu page
  start                                 # sets initial game state
  update_actions(1)                     # registers user presence in the main menu page
  erb :menu                             # main menu view
end

get '/play' do                     # play page
  update_actions(2)	                    # registers user presence in the play page
  erb :play                             # play view
end

post '/play' do                    # play page
  game(params[:guess].upcase)           # game behaviour
  redirect '/win' if successful?        # redirects to win page 
  redirect '/fail' if fail?             # redirects to lose page
  erb :play                             # play view
end

get '/win' do                      # win page
  update_wins                           # increments win counter
  erb :win                              # win view
end

get '/fail' do                     # fail page
  update_loss                           # increments lose counter
  erb :fail                             # lose view
end

get '/rules' do                    # rules page
	update_actions(3)                     # registers user presence in the rules page
	erb :rules                            # rules view
 end

get '/analysis' do                 # statistics page
	update_actions(4)                     # registers user presence in the statistics page
	erb :analysis                         # statistics view
end

get '/about' do                    # creator page
	update_actions(5)                     # registers user presence in the creator page
	erb :about                            # creator view
end
