module ApplicationHelper
  def recent_matches(game)
    @game_id = Game.find_by(name: game).id
    
  end
  
end
