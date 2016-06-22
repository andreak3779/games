require 'yaml/store'

class GameStore
  def initialize(filename)
    @store = YAML::Store.new(filename)
  end

  def all
    @store.transaction do 
       @store.roots.map { |id| @store[id] }
    end
  end 
  
  def find(id)
     @store.transaction do
       @store[id]
     end
  end
  
  def save(game)
    @store.transaction do 
      unless game.id
        highest_id = @store.roots.max || 0
        game.id = highest_id + 1
      end
      @store[game.id] = game
    end
  end

end 
