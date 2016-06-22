require 'sinatra'
require 'game'
require 'game_store'

store = GameStore.new('games.yml')

get('/games') do
  @games = store.all
  erb :index
end

get('/games/new') do
  erb :new
end 

post('/games/create') do
  @game=Game.new
  @game.name = params['name']
  @game.publisher = params['publisher']
  @game.published_date = params['published_date']
  @game.game_console = params['game_console']
  store.save(@game)
  redirect '/games/new'
end

get('/games/:id') do 
  id = params['id'].to_i
  @game = store.find(id)
  erb :show
end
