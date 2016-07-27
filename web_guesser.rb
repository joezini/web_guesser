require 'sinatra'
require 'sinatra/reloader'

set :answer, rand(101)


get '/' do
	guess = params["guess"]
	message = check_guess(guess)
	erb :index, :locals => {:message => message}
end

def check_guess(guess)
	message = "Please make a guess"
	if guess
		guess = guess.to_i
		if guess - 10 > settings.answer
			message = "Way too high!"
		elsif guess > settings.answer
			message = "Too high!"
		elsif guess + 10 < settings.answer
			message = "Way too low!"
		elsif guess < settings.answer
			message = "Too low!"
		else
			message = "You got it right! The SECRET NUMBER is #{settings.answer}"
		end
	end
	message
end