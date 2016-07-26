require 'sinatra'
require 'sinatra/reloader'

answer = rand(101)

get '/' do 
	erb :index, :locals => {:answer => answer}
end