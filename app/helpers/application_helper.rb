module ApplicationHelper
 
 #TODO 
  def get_picked_player(pick)
    @players ||= Player.picked
    
    @players.select{|p| p.pick == pick}.first
  end
  
  def current_pick
    round = current_round
    min_pick = current_round * Team.count - (Team.count - 1)
    max_pick = current_round * Team.count
    
    Rails.logger.debug min_pick.to_s + '-' + max_pick.to_s
    
    (min_pick..max_pick).each do |p|  
      return p if Player.for_pick(p).empty?
    end    
  end
  
  def current_round 
    16.times do |round|
      logger.debug round
      return round if Player.picked.where("pick <= ?", round * Team.count).count < round * 14
    end
  end
end
