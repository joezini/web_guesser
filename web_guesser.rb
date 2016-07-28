require 'sinatra'
require 'sinatra/reloader'

@@answer = rand(101)
@@guesses = 5
INITIAL_COMPARISON = 3

get '/' do
	reset = false
	cheat_mode_on = false
	guess = params["guess"]
	if params["cheat"] == "true"
		cheat_mode_on = true
	end
	comparison = check_guess(guess)
	@@guesses = @@guesses - 1
	if @@guesses == 0 && comparison != 0
		@@guesses = 5
		@@answer = rand(101)
		reset = true
	end
	message = set_message(comparison, reset, cheat_mode_on)
	background_color = set_color(comparison, reset)
	erb :index, :locals => {:message => message, :background_color => background_color}
end

def check_guess(guess)
	comparison = INITIAL_COMPARISON
	if guess
		guess = guess.to_i
		if guess - 10 > @@answer
			comparison = 2
		elsif guess > @@answer
			comparison = 1
		elsif guess + 10 < @@answer
			comparison = -2
		elsif guess < @@answer
			comparison = -1		
		elsif guess == @@answer
			comparison = 0
		end
	end
	comparison
end

def set_message(comparison, reset, cheat_mode_on)
	if reset
		message = "You ran out of guesses :( Starting a new game..."
	else
		case comparison
		when INITIAL_COMPARISON
			message = "Please make a guess"
		when 2
			message = "Way too high!"
		when 1
			message = "Too high!"
		when 0
			message = "You got it right! The SECRET NUMBER is #{@@answer}"
		when -1
			message = "Too low!"
		when -2
			message = "Way too low!"
		end
	end
	if cheat_mode_on
		message = message + "\nCheat mode on: the answer is #{@@answer}"
	end
	message = message + "\nGuesses = #{@@guesses}"
	message
end

def set_color(comparison, reset)
	color = 'white'
	if reset
		color = 'goldenrod'
	else
		case comparison
		when 2, -2
			color = 'firebrick'
		when 1, -1
			color = 'lightpink'
		when 0
			color = 'mediumseagreen'
		end
	end
	color
end