require 'rubygems'
require 'mechanize'
require 'pp'

desc 'Grabs all the rank information from the My Fantasy League ADP Site.'
task :load_adp_rankings => :environment  do |t, args|
  @agent = Mechanize.new
  @players = []

  @bye_weeks = {
    'BAL' => 5,
    'CLE' => 5,
    'DAL' => 5,
    'MIA' => 5,
    'STL' => 5,
    'WAS' => 5,
    'ARI' => 6,
    'DEN' => 6,
    'KCC' => 6,
    'SDC' => 6,
    'SEA' => 6,
    'TEN' => 6,
    'BUF' => 7,
    'CIN' => 7,
    'NEP' => 7,
    'NYG' => 7,
    'PHI' => 7,
    'SFO' => 7,
    'ATL' => 8,
    'CHI' => 8,
    'GBP' => 8,
    'NYJ' => 8,
    'OAK' => 8,
    'TBB' => 8,
    'CAR' => 9,
    'DET' => 9,
    'JAC' => 9,
    'MIN' => 9,
    'HOU' => 11,
    'IND' => 11,
    'NOS' => 11,
    'PIT' => 11
  }

  ['QB','TE','RB','WR','PK','DEF'].each do |position|
    page = @agent.get("http://football.myfantasyleague.com/#{Time.now.year}/adp?COUNT=500&POS=#{position}&CUTOFF=5&FRANCHISES=-1&IS_PPR=-1&IS_KEEPER=0&IS_MOCK=-1&TIME=")
    p page.body
    rows = page.search('table.report tr')

    rows.each do |row|
      next if row.search('th').length > 0
      player = {}

      cells = row.css('td')

      cells.each_with_index do |value, index|
        field = case index
        when 0
          :rank
        when 1
          :player
        when 2
          :average_pick
        when 3
          :minimum_pick
        when 4
          :maximum_pick
        when 5
          :drafts_selected_in
        end

        player[field] = value.text
        if field == :player
          player[:url]  = "http://football.myfantasyleague.com/#{Time.now.year}/" + value.children[0].attributes['href'].value
        end
      end

      player[:player] =~ /(.+),\s(.+)\s(.{3})\s(.{2,3})/
      player[:last_name] = $1
      player[:first_name] = $2
      player[:nfl_team] = $3
      player[:position] = $4

      player[:bye_week] = @bye_weeks[player[:nfl_team]]

      @players << player
    end
  end

  @players.each do |player|
    attributes = player.reject{|k,v| [:player, :drafts_selected_in].include? k }
    Player.create(attributes)
  end
end
