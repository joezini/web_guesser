require 'sinatra'
require 'sinatra/reloader'

answer = rand(101)

get '/' do 
	"The SECRET NUMBER is #{answer}"
end