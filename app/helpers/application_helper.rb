module ApplicationHelper
 
 #TODO 
  def get_picked_player(pick)
    @players ||= Player.picked
    
    @players.select{|p| p.pick == pick}.first
  end
  
  def current_pick
    return @current_pick unless @current_pick.nil?

    round = current_round
    min_pick = current_round * Team.count - (Team.count - 1)
    max_pick = current_round * Team.count
    
    Rails.logger.debug min_pick.to_s + '-' + max_pick.to_s
    
    (min_pick..max_pick).each do |p|  
      if Player.for_pick(p).empty?
        @current_pick = p
        return @current_pick 
      end
    end    
    return 1
  end
  
  def current_round
    return @current_round unless @current_round.nil?

    16.times do |round|
      if Player.picked.where("pick <= ?", round * Team.count).count < round * 14
        @current_round = round
        return @current_round
      end
    end
  end

  def current_team
    Team.with_pick(current_pick)
  end
end
