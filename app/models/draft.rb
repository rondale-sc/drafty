class Draft < ActiveRecord::Base
  belongs_to :team
  belongs_to :player

  def self.current_pick
    where("player_id is NULL").limit(1).first
  end

  def self.current_round
    current_pick.round
  end

  def self.current_team
    current_pick.team
  end
end
