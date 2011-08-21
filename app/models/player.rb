class Player < ActiveRecord::Base
  has_one     :draft

  scope :by_ranking, where('players.average_pick IS NOT NULL').order(:average_pick)
  scope :picked, includes(:draft).where("drafts.id IS NOT NULL")
  scope :available, includes(:draft).where("drafts.id IS NULL")

  scope :for_position, lambda{ |position|
      return self.scoped if position.blank?
      where('players.position = ?', position)
    }
  scope :quaterbacks,     for_position('QB')
  scope :running_backs,   for_position('RB')
  scope :wide_receivers,  for_position('WR')
  scope :tight_ends,      for_position('TE')
  scope :place_kickers,   for_position('PK')
  scope :defenses,        for_position('DEF')

  NFLTeamByeWeeks = {
    'BAL' => 5, 'CLE' => 5, 'DAL' => 5, 'MIA' => 5, 'STL' => 5, 'WAS' => 5,
    'ARI' => 6, 'DEN' => 6, 'KCC' => 6, 'SDC' => 6, 'SEA' => 6, 'TEN' => 6,
    'BUF' => 7, 'CIN' => 7, 'NEP' => 7, 'NYG' => 7, 'PHI' => 7, 'SFO' => 7,
    'ATL' => 8, 'CHI' => 8, 'GBP' => 8, 'NYJ' => 8, 'OAK' => 8, 'TBB' => 8,
    'CAR' => 9, 'DET' => 9, 'JAC' => 9, 'MIN' => 9,
    'HOU' => 11, 'IND' => 11, 'NOS' => 11, 'PIT' => 11
  }

  def self.update_injury_status
    draft_positions = Nokogiri::XML(open("http://football.myfantasyleague.com/#{Time.now.year}/export?TYPE=adp&IS_PPR=1&IS_MOCK=0"))

    draft_positions.xpath("//player").each do |mfl_player|
      player = Player.find_by_mfl_player_id(mfl_player.attributes['id'].value)
      next if player.nil?

      player.update_attributes(
        :average_pick => mfl_player.attributes['averagePick'].value,
        :minimum_pick => mfl_player.attributes['minPick'].value,
        :maximum_pick => mfl_player.attributes['maxPick'].value
      )

      player.save!
    end
  end

  def self.update_rankings
    draft_positions = Nokogiri::XML(open("http://football.myfantasyleague.com/#{Time.now.year}/export?TYPE=adp&IS_PPR=1&IS_MOCK=0"))

    draft_positions.xpath("//player").each do |mfl_player|
      player = Player.find_by_mfl_player_id(mfl_player.attributes['id'].value)
      next if player.nil?

      player.update_attributes(
        :average_pick => mfl_player.attributes['averagePick'].value,
        :minimum_pick => mfl_player.attributes['minPick'].value,
        :maximum_pick => mfl_player.attributes['maxPick'].value
      )

      player.save!
    end
  end

  def self.populate
    players = Nokogiri::XML(open("http://football.myfantasyleague.com/#{Time.now.year}/export?TYPE=players&L=&W="))

    players.xpath("//player").each do |mfl_player|
      player_attributes = {
        :mfl_player_id  => mfl_player.attributes['id'].value,
        :name           => mfl_player.attributes['name'].value,
        :position       => mfl_player.attributes['position'].value.upcase,
        :nfl_team       => mfl_player.attributes['team'].value,
        :bye_week       => NFLTeamByeWeeks[mfl_player.attributes['team'].value]
      }

      next unless ['QB','TE','WR','RB','PK','DEF'].include?(player_attributes[:position])

      player = Player.find_by_mfl_player_id(player_attributes[:mfl_player_id])

      if player.nil?
        player = Player.create(player_attributes)
      else
        player.update_attributes(player_attributes)
      end
    end
  end

  def url
    "http://football.myfantasyleague.com/#{Time.now.year}/player?P=#{self.mfl_player_id}"
  end
end
