require 'sinatra'
require 'sinatra/reloader'

set :answer, rand(101)

get '/' do
	guess = params["guess"]
	comparison = check_guess(guess)
	message = set_message(comparison)
	background_color = set_color(comparison)
	erb :index, :locals => {:message => message, :background_color => background_color}
end

def check_guess(guess)
	comparison = 3
	if guess
		guess = guess.to_i
		if guess - 10 > settings.answer
			comparison = 2
		elsif guess > settings.answer
			comparison = 1
		elsif guess + 10 < settings.answer
			comparison = -2
		elsif guess < settings.answer
			comparison = -1		
		elsif guess == settings.answer
			comparison = 0
		end
	end
	comparison
end

def set_message(comparison)
	message = "Please make a guess"
	case comparison
	when 2
		message = "Way too high!"
	when 1
		message = "Too high!"
	when 0
		message = "You got it right! The SECRET NUMBER is #{settings.answer}"
	when -1
		message = "Too low!"
	when -2
		message = "Way too low!"
	end
	message
end

def set_color(comparison)
	color = 'white'
	case comparison
	when 2, -2
		color = 'firebrick'
	when 1, -1
		color = 'lightpink'
	when 0
		color = 'mediumseagreen'
	end
	color
end