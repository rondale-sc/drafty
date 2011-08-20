class Team < ActiveRecord::Base
  has_many :drafts
  has_many :players, :through => :drafts

  scope :draft_order, order(:draft_order)

  def self.franchise_players(options)
    team_name = options.delete(:player_name)
    players   = options.delete(:players)

    team = Team.where(:player_name => team_name).first
    players.each do |mfl_player_id|
      draft   = team.drafts(true).pending.first
      player  = Player.find_by_mfl_player_id(mfl_player_id)

      draft.player = player
      draft.save!
    end
  end
end
