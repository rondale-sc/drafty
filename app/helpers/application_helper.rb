module ApplicationHelper
 
 #TODO 
  def current_pick
    round = current_round
    pick = current_round * Team.count
    
    Rails.logger.debug pick.to_s + '-' + (pick + 14).to_s
    
    (pick..(pick + 14)).each do |p|  
      return p if Player.for_pick(p).empty?
    end    
  end
  
  def current_round 
    16.times do |round|
      logger.debug round
      return round if Player.picked.where("pick <= ?", round * 14).count < round * 14
    end
  end
end
