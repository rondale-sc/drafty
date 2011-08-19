class Draft < ActiveRecord::Base  
  def self.current_pick
    where("player_id is NULL").first
  end

  def self.current_round
    current_pick.round
  end

  def self.current_team
    current_pick.team
  end
end
