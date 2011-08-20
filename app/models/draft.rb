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

  def self.populate
    teams = Team.draft_order

    (1..16).step(2) do |round|
      teams.each_with_index do |team, index|
        Draft.create(
          :team         => team,
          :round        => round,
          :overall_pick => (index + 1) + ((round - 1) * teams.length)
        )
      end

      round += 1
      teams.reverse.each_with_index do |team, index|
        Draft.create(
          :team         => team,
          :round        => round,
          :overall_pick => (index + 1) + ((round - 1) * teams.length)
        )
      end
    end
  end
end
